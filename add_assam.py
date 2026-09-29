import os
import rasterio
import pandas as pd
import numpy as np
from datetime import datetime

# 1. Create dummy tiles for Assam Border
print("Generating Assam Border tiles...")

dates = ["2023-01-15", "2023-06-15", "2024-01-15", "2024-06-15"]
tiles = []
os.makedirs("data/tiles", exist_ok=True)
os.makedirs("data/thumbs", exist_ok=True)

# Bbox from aois.yaml: [91.80, 27.50, 91.95, 27.65]
lon_min, lat_min, lon_max, lat_max = 91.80, 27.50, 91.95, 27.65
tile_w = (lon_max - lon_min) / 5
tile_h = (lat_max - lat_min) / 4

for date in dates:
    scene_id = f"dummy_scene_{date}"
    for row in range(4):
        for col in range(5):
            tile_id = f"assam_border/{col}_{row}"
            
            # Bounds
            x0 = lon_min + col * tile_w
            y0 = lat_min + row * tile_h
            x1 = x0 + tile_w
            y1 = y0 + tile_h
            
            # Paths
            tif_path = f"data/tiles/{tile_id}_{date}.tif"
            thumb_path = f"data/thumbs/{tile_id}_{date}.jpg"
            os.makedirs(os.path.dirname(tif_path), exist_ok=True)
            os.makedirs(os.path.dirname(thumb_path), exist_ok=True)
            
            # Create dummy TIFF
            with rasterio.open(
                tif_path,
                'w',
                driver='GTiff',
                height=50,
                width=50,
                count=3,
                dtype=rasterio.uint8,
                crs='EPSG:32646'
            ) as dst:
                data = np.random.randint(0, 255, (3, 50, 50), dtype=np.uint8)
                dst.write(data)
                
            # Create dummy JPG
            with open(thumb_path, 'wb') as f:
                f.write(b"dummy")
                
            # Random usable fraction (mostly good)
            uf = np.random.uniform(0.75, 1.0)
            
            tiles.append({
                "tile_id": tile_id,
                "aoi": "assam_border",
                "scene_id": scene_id,
                "bbox_wgs84": [x0, y0, x1, y1],
                "crs": "EPSG:32646",
                "transform": [1, 0, 0, 0, 1, 0],
                "path": tif_path,
                "thumb_path": thumb_path,
                "date": datetime.strptime(date, "%Y-%m-%d"),
                "sensor": "sentinel-2",
                "usable_fraction": uf,
                "coreg_residual": np.random.uniform(0.0, 1.5)
            })

df_new = pd.DataFrame(tiles)

# Append to existing tiles.parquet
df_existing = pd.read_parquet("data/tiles/tiles.parquet")
df_combined = pd.concat([df_existing, df_new], ignore_index=True)
df_combined.to_parquet("data/tiles/tiles.parquet", index=False)

print(f"Added {len(df_new)} dummy tiles for Assam Border.")
print(f"Total tiles now: {len(df_combined)}")
