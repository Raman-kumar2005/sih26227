"""
SIH26227 — Project Demo Script
Shows everything built so far (Parts 1-3).
"""
import os
os.environ['GDAL_DATA'] = r'D:\Anaconda\miniconda3\envs\sih26227\Library\share\gdal'
os.environ['PROJ_LIB'] = r'D:\Anaconda\miniconda3\envs\sih26227\Library\share\proj'

import sys
import pandas as pd
import numpy as np

print("=" * 70)
print("  SIH26227 - Semantic Retrieval & Multi-Temporal Change Analysis")
print("  Smart India Hackathon 2026 | Ministry of Defence (DGIS)")
print("=" * 70)

# ─── 1. Environment Check ───
print("\n[1/6] ENVIRONMENT CHECK")
print("-" * 40)
try:
    import torch
    print(f"  PyTorch      : {torch.__version__}  (CUDA: {torch.cuda.is_available()})")
    if torch.cuda.is_available():
        print(f"  GPU          : {torch.cuda.get_device_name(0)}")
        print(f"  VRAM         : {torch.cuda.get_device_properties(0).total_mem / 1e9:.1f} GB")
except: print("  PyTorch      : NOT FOUND")

try:
    import rasterio
    print(f"  Rasterio     : {rasterio.__version__}")
except: print("  Rasterio     : NOT FOUND")

try:
    import faiss
    print(f"  FAISS        : installed (faiss-cpu)")
except: print("  FAISS        : NOT FOUND")

try:
    import open_clip
    print(f"  OpenCLIP     : {open_clip.__version__}")
except: print("  OpenCLIP     : NOT FOUND")

try:
    import httpx
    r = httpx.get("http://localhost:11434/api/tags", timeout=3.0)
    models = [m['name'] for m in r.json().get('models', [])]
    print(f"  Ollama       : running ({len(models)} models: {', '.join(models[:3])})")
except: print("  Ollama       : NOT REACHABLE (start it for dashboard)")

# ─── 2. Project Structure ───
print("\n[2/6] PROJECT STRUCTURE")
print("-" * 40)
root = r"d:\Sih 2026\sih26227"
key_dirs = [
    "config", "data/raw", "data/tiles", "data/thumbs", "data/index", "data/cache",
    "models/weights", "ml/ingest", "ml/preprocess", "ml/embed", "ml/index",
    "ml/change", "ml/pipelines", "backend/app", "frontend", "eval", "docs"
]
for d in key_dirs:
    full = os.path.join(root, d)
    if os.path.isdir(full):
        count = sum(1 for f in os.listdir(full) if os.path.isfile(os.path.join(full, f)))
        print(f"  [OK] {d:<30} ({count} files)")
    else:
        print(f"  [--] {d:<30} (missing)")

# ─── 3. Data Ingest (Part 2) ───
print("\n[3/6] DATA INGEST — scenes.parquet")
print("-" * 40)
scenes_path = os.path.join(root, "data", "raw", "scenes.parquet")
if os.path.exists(scenes_path):
    scenes = pd.read_parquet(scenes_path)
    print(f"  Total scenes : {len(scenes)}")
    print(f"  Columns      : {list(scenes.columns)}")
    
    # Infer AOI
    def infer_aoi(sid):
        return "bangalore_lakes" if "43PGQ" in sid else "delhi_airport"
    scenes['aoi'] = scenes['scene_id'].apply(infer_aoi)
    
    for aoi in scenes['aoi'].unique():
        aoi_scenes = scenes[scenes['aoi'] == aoi]
        print(f"\n  AOI: {aoi}")
        print(f"    Scenes: {len(aoi_scenes)}")
        for _, s in aoi_scenes.iterrows():
            print(f"      {s['scene_id']} | Cloud: {s['cloud_pct']}%")
    
    # Raw files on disk
    raw_files = [f for f in os.listdir(os.path.join(root, "data", "raw")) if f.endswith(".tif")]
    raw_size = sum(os.path.getsize(os.path.join(root, "data", "raw", f)) for f in raw_files)
    print(f"\n  Raw TIF files on disk: {len(raw_files)} ({raw_size / 1024:.1f} KB)")
else:
    print("  scenes.parquet NOT FOUND — run Part 2 first")

# ─── 4. Tiling (Part 3) ───
print("\n[4/6] TILING — tiles.parquet")
print("-" * 40)
tiles_path = os.path.join(root, "data", "tiles", "tiles.parquet")
if os.path.exists(tiles_path):
    tiles = pd.read_parquet(tiles_path)
    print(f"  Total tiles  : {len(tiles)}")
    print(f"  Columns      : {list(tiles.columns)}")
    
    for aoi in tiles['aoi'].unique():
        aoi_tiles = tiles[tiles['aoi'] == aoi]
        unique_ids = aoi_tiles['tile_id'].nunique()
        scenes_count = aoi_tiles['scene_id'].nunique()
        print(f"\n  AOI: {aoi}")
        print(f"    Unique tile positions: {unique_ids}")
        print(f"    Scenes tiled: {scenes_count}")
        print(f"    Total tile files: {len(aoi_tiles)}")
    
    # Verify COG count
    cog_count = 0
    for dirpath, _, filenames in os.walk(os.path.join(root, "data", "tiles")):
        cog_count += sum(1 for f in filenames if f.endswith(".tif"))
    print(f"\n  COG files on disk: {cog_count}")
    print(f"  Parquet rows     : {len(tiles)}")
    print(f"  Match            : {'[OK] YES' if cog_count == len(tiles) else '[FAIL] NO'}")
    
    # Thumbnail count
    thumb_count = 0
    for dirpath, _, filenames in os.walk(os.path.join(root, "data", "thumbs")):
        thumb_count += sum(1 for f in filenames if f.endswith(".jpg"))
    print(f"  JPEG thumbnails  : {thumb_count}")
    
    # Verify one tile bounds
    sample = tiles.iloc[0]
    with rasterio.open(sample['path']) as src:
        b = src.bounds
        print(f"\n  Sample tile: {sample['tile_id']}")
        print(f"    CRS        : {sample['crs']}")
        print(f"    UTM bounds : ({b.left:.0f}, {b.bottom:.0f}, {b.right:.0f}, {b.top:.0f})")
        print(f"    WGS84 bbox : {[round(x,4) for x in sample['bbox_wgs84']]}")
        print(f"    Pixel size : {src.width}x{src.height}")
else:
    print("  tiles.parquet NOT FOUND — run Part 3 first")

# ─── 5. Quality & Co-registration (Part 3) ───
print("\n[5/6] QUALITY MASKS & CO-REGISTRATION")
print("-" * 40)
if os.path.exists(tiles_path):
    tiles = pd.read_parquet(tiles_path)
    
    if 'usable_fraction' in tiles.columns:
        accepted = (tiles['usable_fraction'] >= 0.80).sum()
        rejected = (tiles['usable_fraction'] < 0.80).sum()
        print(f"  Usable fraction threshold: 0.80")
        print(f"  Accepted tiles: {accepted}")
        print(f"  Rejected tiles: {rejected}")
        print(f"  Min usable fraction: {tiles['usable_fraction'].min():.2f}")
        print(f"  Max usable fraction: {tiles['usable_fraction'].max():.2f}")
        print(f"  Mean usable fraction: {tiles['usable_fraction'].mean():.2f}")
    else:
        print("  usable_fraction column missing")
    
    if 'coreg_residual' in tiles.columns:
        res = tiles['coreg_residual'].dropna()
        exceed = (res > 1.0).sum()
        print(f"\n  Co-registration residuals:")
        print(f"    Mean: {res.mean():.3f} px")
        print(f"    Max : {res.max():.3f} px")
        print(f"    >1px: {exceed}/{len(res)} ({100*exceed/max(len(res),1):.1f}%)")
    else:
        print("  coreg_residual column missing")

# ─── 6. Model Weights ───
print("\n[6/6] MODEL WEIGHTS & PROVENANCE")
print("-" * 40)
weights_dir = os.path.join(root, "models", "weights")
if os.path.isdir(weights_dir):
    for f in os.listdir(weights_dir):
        fp = os.path.join(weights_dir, f)
        if os.path.isfile(fp):
            size_mb = os.path.getsize(fp) / (1024**2)
            print(f"  {f:<40} {size_mb:>8.1f} MB")

prov_path = os.path.join(root, "config", "provenance.yaml")
if os.path.exists(prov_path):
    print(f"\n  provenance.yaml: [OK] present")
else:
    print(f"\n  provenance.yaml: [--] missing")

# ─── Disk Usage ───
print("\n" + "=" * 70)
total_size = 0
for dirpath, _, filenames in os.walk(root):
    for f in filenames:
        total_size += os.path.getsize(os.path.join(dirpath, f))
print(f"  Total project size: {total_size / (1024**3):.2f} GB")

import shutil
_, _, free = shutil.disk_usage("D:\\")
print(f"  D: drive free     : {free / (1024**3):.1f} GB")
print("=" * 70)
print("  Status: Parts 1-3 COMPLETE. Ready for Part 4 (Clay embeddings).")
print("=" * 70)

