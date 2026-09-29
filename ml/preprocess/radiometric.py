"""
Docstring for radiometric.py.
Part 3.4 — Relative radiometric normalisation.

Histogram-matches each tile to the AOI reference date.
Limitation: simple histogram matching normalises brightness distributions
but does NOT correct for atmospheric composition, view geometry, or BRDF.
For a full solution, use Sen2Cor L2A (already applied) + BRDF correction.
"""
import numpy as np
import rasterio


def histogram_match(source: np.ndarray, reference: np.ndarray) -> np.ndarray:
    """
    Match the histogram of source to reference, per band.
    Both arrays are (C, H, W).
    """
    matched = np.zeros_like(source)
    for c in range(source.shape[0]):
        src_band = source[c].ravel()
        ref_band = reference[c].ravel()
        
        # Compute CDFs
        src_vals, src_counts = np.unique(src_band, return_counts=True)
        ref_vals, ref_counts = np.unique(ref_band, return_counts=True)
        
        src_cdf = np.cumsum(src_counts).astype(float) / src_band.size
        ref_cdf = np.cumsum(ref_counts).astype(float) / ref_band.size
        
        # Map source values to reference values via CDF matching
        interp_vals = np.interp(src_cdf, ref_cdf, ref_vals)
        
        # Build lookup
        lookup = dict(zip(src_vals, interp_vals.astype(source.dtype)))
        matched[c] = np.vectorize(lookup.get)(source[c])
    
    return matched


def apply_radiometric_norm(tiles_df):
    """
    For each AOI, histogram-match all tiles to the reference date.
    Modifies tiles in-place on disk.
    """
    tiles_df_copy = tiles_df.copy()
    
    for aoi in tiles_df_copy['aoi'].unique():
        aoi_tiles = tiles_df_copy[tiles_df_copy['aoi'] == aoi]
        dates = sorted(aoi_tiles['date'].unique())
        ref_date = dates[0]
        
        ref_tiles = aoi_tiles[aoi_tiles['date'] == ref_date]
        ref_lookup = dict(zip(ref_tiles['tile_id'], ref_tiles['path']))
        
        matched_count = 0
        for _, row in aoi_tiles.iterrows():
            if row['date'] == ref_date:
                continue  # Skip reference
            
            ref_path = ref_lookup.get(row['tile_id'])
            if not ref_path:
                continue
            
            with rasterio.open(ref_path) as ref_src:
                ref_data = ref_src.read()
            
            with rasterio.open(row['path']) as tile_src:
                tile_data = tile_src.read()
                profile = tile_src.profile
            
            matched_data = histogram_match(tile_data, ref_data)
            
            with rasterio.open(row['path'], 'w', **profile) as dst:
                dst.write(matched_data)
            
            matched_count += 1
        
        print(f"  Radiometric norm ({aoi}): matched {matched_count} tiles to ref date {ref_date}",
              flush=True)
    
    print("  Limitation: simple histogram matching — does not correct for "
          "atmospheric composition, view geometry, or BRDF.", flush=True)
    
    return tiles_df_copy
