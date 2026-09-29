"""
Docstring for quality_mask.py.
Part 3.2 — Quality mask per tile.

Computes usable_fraction from the Sentinel-2 SCL band (or simulated equivalent).
Rejects tiles with cloud, cloud shadow, snow/ice, cirrus, saturated, no-data
above a configurable threshold.
"""
import os
import numpy as np
import rasterio

# Sentinel-2 SCL classes to MASK (non-usable)
SCL_MASK_CLASSES = {
    0,   # no_data
    1,   # saturated_or_defective
    2,   # dark_area_pixels (topographic shadow)
    3,   # cloud_shadows
    8,   # cloud_medium_probability
    9,   # cloud_high_probability
    10,  # thin_cirrus
    11,  # snow_ice
}

USABLE_FRACTION_THRESHOLD = 0.80  # reject if usable < 80% (i.e. >20% bad)


def compute_usable_fraction(tile_path: str) -> float:
    """
    Compute the fraction of pixels that are 'usable' (not cloud/shadow/snow/nodata).
    
    For our dummy 3-band RGB tiles (no real SCL band), we simulate:
    - Pixels where ALL bands == 0 are treated as no-data.
    - Everything else is usable.
    
    For real Sentinel-2 with SCL band, we would check SCL class membership.
    """
    with rasterio.open(tile_path) as src:
        data = src.read()  # (C, H, W)
        
        total_pixels = data.shape[1] * data.shape[2]
        if total_pixels == 0:
            return 0.0
        
        # Check for no-data: all bands == 0
        nodata_mask = np.all(data == 0, axis=0)  # (H, W)
        usable_count = total_pixels - nodata_mask.sum()
        
        return float(usable_count / total_pixels)


def compute_quality_for_tiles(tiles_df):
    """
    Add usable_fraction column to tiles dataframe.
    Returns the dataframe with the new column and a rejection summary.
    """
    fractions = []
    for _, row in tiles_df.iterrows():
        frac = compute_usable_fraction(row['path'])
        fractions.append(frac)
    
    tiles_df = tiles_df.copy()
    tiles_df['usable_fraction'] = fractions
    
    rejected = tiles_df[tiles_df['usable_fraction'] < USABLE_FRACTION_THRESHOLD]
    accepted = tiles_df[tiles_df['usable_fraction'] >= USABLE_FRACTION_THRESHOLD]
    
    print(f"  Quality masks: {len(accepted)} accepted, {len(rejected)} rejected "
          f"(threshold: {USABLE_FRACTION_THRESHOLD})", flush=True)
    
    return tiles_df
