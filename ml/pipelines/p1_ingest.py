import os
import argparse
import yaml
import pandas as pd
from typing import List

from ml.ingest.base import SceneMeta
from ml.ingest.stac_source import EarthSearchSTACAdapter
from ml.ingest.local_folder import LocalFolderAdapter

def load_aois(config_path: str):
    with open(config_path, "r") as f:
        return yaml.safe_load(f)

def run_ingest(dry_run: bool = False):
    print(f"--- INGEST PIPELINE START (Dry Run: {dry_run}) ---")
    
    aoi_config = load_aois("config/aois.yaml")
    stac_adapter = LocalFolderAdapter("data/raw")
    
    all_scenes: List[SceneMeta] = []
    
    for aoi_name, aoi_data in aoi_config.items():
        print(f"\nProcessing AOI: {aoi_name}")
        bbox = tuple(aoi_data["bbox_wgs84"])
        date_window = tuple(aoi_data["date_window"])
        
        scenes = stac_adapter.list_scenes(aoi_name, bbox, date_window, max_items=8)
        
        print(f"Found {len(scenes)} scenes for {aoi_name}:")
        for s in scenes:
            print(f"  - {s.scene_id} | Date: {s.acquisition_datetime.date()} | Cloud: {s.cloud_pct:.1f}%")
        
        all_scenes.extend(scenes)
        
        if not dry_run:
            out_dir = os.path.join("data", "raw")
            os.makedirs(out_dir, exist_ok=True)
            for s in scenes:
                stac_adapter.fetch(s, out_dir)
            print(f"Stopping after 1 AOI for gate check.")
            break
                
    if not dry_run:
        # Save to scenes.parquet
        df = pd.DataFrame([s.model_dump() for s in all_scenes])
        # Convert datetime to datetime64[ns] to avoid arrow serialization issues with timezones
        df['acquisition_datetime'] = pd.to_datetime(df['acquisition_datetime'], utc=True).dt.tz_convert(None)
        
        parquet_path = os.path.join("data", "raw", "scenes.parquet")
        df.to_parquet(parquet_path, index=False)
        print(f"\nSaved metadata for {len(all_scenes)} scenes to {parquet_path}")
        
    print("\n--- INGEST PIPELINE COMPLETE ---")

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--dry-run", action="store_true", help="List scenes without downloading")
    args = parser.parse_args()
    
    run_ingest(dry_run=args.dry_run)
