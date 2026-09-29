"""
Part 5.3 — Spectral Indices.

NDVI, NDBI, NDWI per date and their deltas vs the seasonal baseline.
No ML, no GPU. Physically grounded path.

NOTE: Real Sentinel-2 has:
- Red: B04
- NIR: B08
- SWIR: B11
Since our dummy tiles only have 3 RGB channels, we will map them pseudo-bands:
Channel 0 -> Red
Channel 1 -> NIR
Channel 2 -> SWIR
(In a real deployment, config/settings.yaml will map band indices correctly).
"""
import numpy as np
import rasterio

def compute_indices(tile_path: str):
    """Compute mean index values for a tile."""
    # Add small epsilon to avoid divide by zero
    eps = 1e-8
    with rasterio.open(tile_path) as src:
        data = src.read().astype(np.float32)
        
    # Pseudo-band mapping for dummy data
    red = data[0]
    nir = data[1] if data.shape[0] > 1 else data[0]
    swir = data[2] if data.shape[0] > 2 else data[0]
    
    # NDVI = (NIR - Red) / (NIR + Red)
    ndvi = (nir - red) / (nir + red + eps)
    
    # NDBI = (SWIR - NIR) / (SWIR + NIR)
    ndbi = (swir - nir) / (swir + nir + eps)
    
    # NDWI = (Green - NIR) / (Green + NIR). We don't have green, use red for dummy
    ndwi = (red - nir) / (red + nir + eps)
    
    return float(np.mean(ndvi)), float(np.mean(ndbi)), float(np.mean(ndwi))
