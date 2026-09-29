"""
Docstring for tiling.py.
Part 3 — Tiling, quality masks, co-registration foundation.

Uses rasterio for CRS-aware tiling with a FIXED grid per AOI.
Reprojection to local UTM zone, deterministic tile IDs.
"""
import os
import math
import warnings
from typing import List, Dict, Any, Tuple
import rasterio
from rasterio.warp import calculate_default_transform, reproject, Resampling
import pyproj
import numpy as np
from PIL import Image


def get_utm_crs(lon: float, lat: float) -> str:
    """Calculate UTM zone EPSG code from longitude and latitude."""
    zone = (math.floor((lon + 180) / 6) % 60) + 1
    epsg = 32600 + zone if lat >= 0 else 32700 + zone
    return f"EPSG:{epsg}"


def reproject_to_utm(src_path: str, dst_path: str, dst_crs: str) -> None:
    """Reprojects a raster to a target CRS."""
    with rasterio.open(src_path) as src:
        transform, width, height = calculate_default_transform(
            src.crs, dst_crs, src.width, src.height, *src.bounds
        )
        kwargs = src.meta.copy()
        kwargs.update({
            'crs': dst_crs,
            'transform': transform,
            'width': width,
            'height': height,
            'driver': 'GTiff'
        })
        with rasterio.open(dst_path, 'w', **kwargs) as dst:
            for i in range(1, src.count + 1):
                reproject(
                    source=rasterio.band(src, i),
                    destination=rasterio.band(dst, i),
                    src_transform=src.transform,
                    src_crs=src.crs,
                    dst_transform=transform,
                    dst_crs=dst_crs,
                    resampling=Resampling.nearest
                )


def save_thumbnail(data: np.ndarray, path: str):
    """Save a 3-band (C, H, W) array as JPEG thumbnail."""
    if data.shape[0] >= 3:
        img_arr = data[:3].transpose(1, 2, 0)
    else:
        img_arr = np.stack([data[0]] * 3, axis=-1)
    if img_arr.dtype != np.uint8:
        mx = img_arr.max()
        if mx > 0:
            img_arr = (np.clip(img_arr / mx, 0, 1) * 255).astype(np.uint8)
        else:
            img_arr = np.zeros_like(img_arr, dtype=np.uint8)
    img = Image.fromarray(img_arr)
    img.thumbnail((256, 256))
    img.save(path, format='JPEG', quality=85)


def tile_scene(scene_id: str, aoi: str, src_path: str, aoi_crs: str,
               tile_size_px: int = 50) -> List[Dict[str, Any]]:
    """
    Tiles a single scene into COGs and thumbnails.
    
    tile_size_px: tile size in pixels (50 px x ~11 m/px ≈ 550 m tiles).
    Returns list of metadata dicts for each tile.
    """
    temp_utm_path = src_path.replace(".tif", "_utm_temp.tif")
    
    # Step 1: Reproject to UTM
    print(f"    Reprojecting to {aoi_crs}...", flush=True)
    reproject_to_utm(src_path, temp_utm_path, aoi_crs)
    
    out_dir_tiles = os.path.join("data", "tiles", aoi)
    out_dir_thumbs = os.path.join("data", "thumbs", aoi)
    os.makedirs(out_dir_tiles, exist_ok=True)
    os.makedirs(out_dir_thumbs, exist_ok=True)
    
    records = []
    
    # Step 2: Open reprojected raster and tile with windowed reads
    with rasterio.open(temp_utm_path) as src:
        n_cols = math.ceil(src.width / tile_size_px)
        n_rows = math.ceil(src.height / tile_size_px)
        print(f"    Raster {src.width}x{src.height} px -> {n_cols}x{n_rows} = {n_cols * n_rows} tiles", flush=True)
        
        transformer = pyproj.Transformer.from_crs(aoi_crs, "EPSG:4326", always_xy=True)
        
        for row_idx in range(n_rows):
            for col_idx in range(n_cols):
                # Pixel offsets
                px_off = col_idx * tile_size_px
                py_off = row_idx * tile_size_px
                px_width = min(tile_size_px, src.width - px_off)
                py_height = min(tile_size_px, src.height - py_off)
                
                window = rasterio.windows.Window(px_off, py_off, px_width, py_height)
                data = src.read(window=window)
                win_transform = rasterio.windows.transform(window, src.transform)
                
                # Deterministic tile ID based on grid position
                tile_id = f"{aoi}/{col_idx}_{row_idx}"
                
                tile_path = os.path.join(out_dir_tiles, f"{scene_id}_{col_idx}_{row_idx}.tif")
                thumb_path = os.path.join(out_dir_thumbs, f"{scene_id}_{col_idx}_{row_idx}.jpg")
                
                # Write tile COG
                kwargs = src.meta.copy()
                kwargs.update({
                    'height': py_height,
                    'width': px_width,
                    'transform': win_transform,
                })
                with rasterio.open(tile_path, 'w', **kwargs) as dst:
                    dst.write(data)
                
                # Save thumbnail
                save_thumbnail(data, thumb_path)
                
                # Compute WGS84 bbox from the tile's UTM bounds
                minx = win_transform.c  # left
                maxy = win_transform.f  # top
                maxx = minx + px_width * win_transform.a
                miny = maxy + py_height * win_transform.e  # e is negative
                lon_min, lat_min = transformer.transform(minx, miny)
                lon_max, lat_max = transformer.transform(maxx, maxy)
                
                records.append({
                    'tile_id': tile_id,
                    'aoi': aoi,
                    'scene_id': scene_id,
                    'bbox_wgs84': [lon_min, lat_min, lon_max, lat_max],
                    'crs': aoi_crs,
                    'transform': list(win_transform)[:6],
                    'path': tile_path,
                    'thumb_path': thumb_path,
                })
    
    # Cleanup temp raster
    if os.path.exists(temp_utm_path):
        os.remove(temp_utm_path)
    
    print(f"    {len(records)} tiles created.", flush=True)
    return records
