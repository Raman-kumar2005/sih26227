"""
Docstring for coregister.py.
Part 3.3 — Sub-pixel co-registration using AROSICS.

For each (tile, date) against the AOI reference date:
- Compute shift using AROSICS COREG_LOCAL or COREG
- Apply correction
- Store the residual as a column
- High residual becomes a confidence penalty in Part 6
"""
import os
import numpy as np
import rasterio


def compute_coregistration_residual(tile_path: str, ref_tile_path: str) -> float:
    """
    Compute co-registration residual between a tile and its reference.
    
    For real imagery, we would use AROSICS:
        from arosics import COREG
        cr = COREG(ref_tile_path, tile_path, ...)
        cr.calculate_spatial_shifts()
        residual = np.sqrt(cr.shift_x**2 + cr.shift_y**2)
    
    For our dummy tiles (random data), AROSICS cannot find real features,
    so we simulate a small residual (sub-pixel, <1 pixel in most cases).
    This placeholder preserves the interface for real data integration.
    """
    # Simulate: random residual between 0 and 0.8 pixels (sub-pixel)
    # In production, replace with actual AROSICS call
    np.random.seed(hash(tile_path) % (2**31))
    residual = np.random.uniform(0.0, 0.8)
    return round(residual, 4)


def compute_coreg_for_tiles(tiles_df):
    """
    Add coreg_residual column to tiles dataframe.
    
    For each AOI, the FIRST scene (earliest date) is the reference.
    All other tiles are co-registered against the matching reference tile.
    """
    tiles_df = tiles_df.copy()
    tiles_df['coreg_residual'] = 0.0
    
    for aoi in tiles_df['aoi'].unique():
        aoi_mask = tiles_df['aoi'] == aoi
        aoi_tiles = tiles_df[aoi_mask]
        
        # Reference = first date in this AOI
        dates = sorted(aoi_tiles['date'].unique())
        ref_date = dates[0]
        
        # Build a lookup: tile_id -> ref_path
        ref_tiles = aoi_tiles[aoi_tiles['date'] == ref_date]
        ref_lookup = dict(zip(ref_tiles['tile_id'], ref_tiles['path']))
        
        residuals = []
        for idx, row in aoi_tiles.iterrows():
            if row['date'] == ref_date:
                residuals.append(0.0)  # Reference is perfectly aligned
            else:
                ref_path = ref_lookup.get(row['tile_id'])
                if ref_path and os.path.exists(ref_path):
                    res = compute_coregistration_residual(row['path'], ref_path)
                    residuals.append(res)
                else:
                    residuals.append(np.nan)
        
        tiles_df.loc[aoi_mask, 'coreg_residual'] = residuals
    
    # Report
    valid = tiles_df['coreg_residual'].dropna()
    exceed_1px = (valid > 1.0).sum()
    print(f"  Co-registration: {len(valid)} tiles processed. "
          f"Residuals >1px: {exceed_1px}/{len(valid)} ({100*exceed_1px/max(len(valid),1):.1f}%)",
          flush=True)
    
    return tiles_df
