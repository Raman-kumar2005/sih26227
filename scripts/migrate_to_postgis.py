#!/usr/bin/env python3
"""
SIH 2026 Problem ID: 26227
Data Migration Pipeline: Parquet / GeoJSON -> PostGIS Spatial Database

This script:
1. Loads all scored change detections from data/index/changes_scored.parquet.
2. Extracts geometries, embeddings, scores, dates, and confidence breakdown.
3. Generates seed SQL (docker/seed_data.sql) for Docker container entrypoint.
4. If DATABASE_URL is set or a live PostgreSQL connection is active, performs direct batch ingestion.
"""

import os
import json
import pandas as pd
from shapely import wkt
import shapely.geometry

def generate_seed_sql(parquet_path: str, output_sql_path: str):
    print(f"Reading changes from: {parquet_path}")
    if not os.path.exists(parquet_path):
        print(f"Error: {parquet_path} not found.")
        return

    df = pd.read_parquet(parquet_path)
    print(f"Loaded {len(df)} records.")

    lines = []
    lines.append("-- Auto-generated PostGIS seed data for SIH 2026")
    lines.append("BEGIN;\n")

    for idx, row in df.iterrows():
        change_id = str(row.get('change_id', '')).replace("'", "''")
        tile_id = str(row.get('tile_id', '')).replace("'", "''")
        aoi = str(row.get('aoi', '')).replace("'", "''")
        detected_date = str(row.get('date', '2026-09-04 12:00:00'))
        baseline_ref = str(row.get('baseline_ref', 'monsoon_N=8')).replace("'", "''")
        sensor = str(row.get('sensor', 'sentinel-2')).replace("'", "''")
        embed_dist = float(row.get('embed_distance', 0.0) or 0.0)
        embed_zscore = float(row.get('embed_zscore', 0.0) or 0.0)
        dndvi = float(row.get('dndvi', 0.0) or 0.0)
        dndbi = float(row.get('dndbi', 0.0) or 0.0)
        dndwi = float(row.get('dndwi', 0.0) or 0.0)
        usable_fraction = float(row.get('usable_fraction', 1.0) or 1.0)
        coreg_residual = float(row.get('coreg_residual', 0.0) or 0.0)
        confidence = float(row.get('confidence', 0.5) or 0.5)

        breakdown = row.get('confidence_breakdown', {})
        if isinstance(breakdown, str):
            try:
                breakdown = json.loads(breakdown)
            except:
                breakdown = {}
        breakdown_json = json.dumps(breakdown).replace("'", "''")

        geom_val = row.get('geometry')
        # Ensure valid WKT
        if hasattr(geom_val, 'wkt'):
            wkt_str = geom_val.wkt
        else:
            wkt_str = str(geom_val)

        sql = f"""INSERT INTO changes (
            change_id, tile_id, aoi, detected_date, baseline_ref, sensor,
            embed_distance, embed_zscore, dndvi, dndbi, dndwi,
            usable_fraction, coreg_residual, confidence, confidence_breakdown, geom
        ) VALUES (
            '{change_id}', '{tile_id}', '{aoi}', '{detected_date}', '{baseline_ref}', '{sensor}',
            {embed_dist:.6f}, {embed_zscore:.6f}, {dndvi:.6f}, {dndbi:.6f}, {dndwi:.6f},
            {usable_fraction:.4f}, {coreg_residual:.4f}, {confidence:.4f}, '{breakdown_json}'::jsonb,
            ST_GeomFromText('{wkt_str}', 4326)
        ) ON CONFLICT (change_id) DO UPDATE SET
            confidence = EXCLUDED.confidence,
            embed_zscore = EXCLUDED.embed_zscore,
            geom = EXCLUDED.geom;"""
        lines.append(sql)

    lines.append("\nCOMMIT;")

    os.makedirs(os.path.dirname(output_sql_path), exist_ok=True)
    with open(output_sql_path, "w", encoding="utf-8") as f:
        f.write("\n".join(lines))

    print(f"Successfully exported {len(df)} records into SQL seed script: {output_sql_path}")

def migrate_to_live_db(database_url: str, parquet_path: str):
    """Direct bulk migration into live PostGIS database via SQLAlchemy."""
    from sqlalchemy import create_engine, text
    import geopandas as gpd

    print(f"Connecting to database: {database_url}")
    engine = create_engine(database_url)

    df = pd.read_parquet(parquet_path)
    # Parse geometry to shapely
    df['geometry'] = df['geometry'].apply(lambda g: wkt.loads(g) if isinstance(g, str) else g)
    gdf = gpd.GeoDataFrame(df, geometry='geometry', crs="EPSG:4326")

    with engine.connect() as conn:
        print("Ensuring PostGIS extensions and schema...")
        with open("docker/init_postgis.sql", "r") as f:
            schema_sql = f.read()
        conn.execute(text(schema_sql))
        conn.commit()

        print(f"Ingesting {len(gdf)} spatial records via PostGIS driver...")
        gdf.to_postgis("changes", engine, if_exists="append", index=False)
        print("Live PostGIS migration completed successfully!")

if __name__ == "__main__":
    parquet_file = "data/index/changes_scored.parquet"
    seed_sql_file = "docker/seed_data.sql"
    generate_seed_sql(parquet_file, seed_sql_file)

    db_url = os.getenv("DATABASE_URL")
    if db_url and db_url.startswith("postgres"):
        try:
            migrate_to_live_db(db_url, parquet_file)
        except Exception as e:
            print(f"Live DB migration skipped or failed: {e}")
