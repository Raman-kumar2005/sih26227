"""
Part 5.1 — Seasonal Baseline.

Per tile, build a seasonal baseline from the time series:
- Median embedding of observations in the same season across available years
- Plus the spread (standard deviation or MAD).

Seasonal Binning (India Context):
- Pre-monsoon: Mar, Apr, May (Months 3,4,5)
- Monsoon: Jun, Jul, Aug, Sep (Months 6,7,8,9)
- Post-monsoon: Oct, Nov, Dec, Jan, Feb (Months 10,11,12,1,2)
"""
import numpy as np
import pandas as pd
from typing import Dict, Any

def get_season(month: int) -> str:
    """Map month to Indian season."""
    if month in [3, 4, 5]:
        return "pre-monsoon"
    elif month in [6, 7, 8, 9]:
        return "monsoon"
    else:
        return "post-monsoon"

def compute_seasonal_baselines(embeddings_df: pd.DataFrame, vector_store) -> pd.DataFrame:
    """
    Given a dataframe of tiles with dates and FAISS IDs, compute the seasonal
    baseline (median + spread) for each unique tile position in each season.
    """
    # Create season column
    df = embeddings_df.copy()
    df['date'] = pd.to_datetime(df['date'])
    df['season'] = df['date'].dt.month.apply(get_season)
    
    # We define a 'tile location' by stripping the date from tile_id or grouping by bounds.
    # Our tile_ids are formatted like: aoi/col_row
    df['tile_loc'] = df['aoi'] + '/' + df['tile_id'].apply(lambda x: x.split('/')[-1])
    
    baselines = []
    
    # Group by tile location and season
    for (loc, season), group in df.groupby(['tile_loc', 'season']):
        faiss_ids = group['faiss_id'].values
        
        # Reconstruct vectors from FAISS
        vecs = []
        for fid in faiss_ids:
            try:
                v = vector_store.index.reconstruct(int(fid))
                vecs.append(v)
            except:
                pass
                
        if len(vecs) == 0:
            continue
            
        vecs = np.vstack(vecs)
        
        # Median embedding (L2 normalized)
        median_vec = np.median(vecs, axis=0)
        norm = np.linalg.norm(median_vec)
        if norm > 0:
            median_vec = median_vec / norm
            
        # Spread: mean distance to median
        # Distance = 1 - cosine similarity (since vectors are L2 normalized, dot product is cos sim)
        sims = np.dot(vecs, median_vec)
        dists = 1.0 - sims
        spread = np.std(dists) if len(dists) > 1 else 0.01 # minimum spread to avoid div by zero
        
        baselines.append({
            'tile_loc': loc,
            'season': season,
            'median_vec': median_vec,
            'spread': max(spread, 0.001),  # strict min bound
            'obs_count': len(vecs)
        })
        
    return pd.DataFrame(baselines)
