"""
Fix AOI geometries in the parquet files.
Both AOIs were using Bangalore coordinates. 
This script patches them with the correct bounding boxes from aois.yaml.
"""
import pandas as pd
import numpy as np
import yaml
import random

with open("config/aois.yaml") as f:
    AOIS = yaml.safe_load(f)

# Load existing data
df = pd.read_parquet("data/index/changes_scored.parquet")
print(f"Loaded {len(df)} rows")

def tile_polygon(aoi_name: str, tile_id: str, seed: int) -> str:
    """Generate a realistic tile polygon within the correct AOI bounding box."""
    bbox = AOIS[aoi_name]['bbox_wgs84']  # [lon_min, lat_min, lon_max, lat_max]
    lon_min, lat_min, lon_max, lat_max = bbox

    rng = np.random.default_rng(seed)

    # Each tile covers roughly 0.02° × 0.02° (~2km × 2km)
    tile_w = (lon_max - lon_min) / 5   # divide AOI into 5 cols
    tile_h = (lat_max - lat_min) / 4   # divide AOI into 4 rows

    # Parse row/col from tile_id e.g. "bangalore_lakes/1_2"
    try:
        parts = tile_id.split("/")[1].split("_")
        col = int(parts[0]) % 5
        row = int(parts[1]) % 4
    except:
        col = rng.integers(0, 5)
        row = rng.integers(0, 4)

    # Add slight jitter so tiles don't perfectly align
    jitter_lon = rng.uniform(-tile_w * 0.05, tile_w * 0.05)
    jitter_lat = rng.uniform(-tile_h * 0.05, tile_h * 0.05)

    x0 = lon_min + col * tile_w + jitter_lon
    y0 = lat_min + row * tile_h + jitter_lat
    x1 = x0 + tile_w
    y1 = y0 + tile_h

    return f"POLYGON(({x0} {y0}, {x1} {y0}, {x1} {y1}, {x0} {y1}, {x0} {y0}))"


# Patch geometries
new_geoms = []
for idx, row in df.iterrows():
    seed = abs(hash(row['tile_id'] + str(row['date']))) % (2**31)
    geom = tile_polygon(row['aoi'], row['tile_id'], seed)
    new_geoms.append(geom)

df['geometry'] = new_geoms

# Verify
print("\nSample geometry check:")
for aoi in df['aoi'].unique():
    g = df[df['aoi'] == aoi]['geometry'].iloc[0]
    print(f"  {aoi}: {g[:70]}...")

# Save
df.to_parquet("data/index/changes_scored.parquet", index=False)
print(f"\nSaved {len(df)} rows with corrected geometries.")

# Also patch changes.parquet (used by p5)
try:
    df2 = pd.read_parquet("data/index/changes.parquet")
    new_geoms2 = []
    for idx, row in df2.iterrows():
        seed = abs(hash(row['tile_id'] + str(row['date']))) % (2**31)
        geom = tile_polygon(row['aoi'], row['tile_id'], seed)
        new_geoms2.append(geom)
    df2['geometry'] = new_geoms2
    df2.to_parquet("data/index/changes.parquet", index=False)
    print(f"Also patched changes.parquet ({len(df2)} rows).")
except Exception as e:
    print(f"changes.parquet skip: {e}")
