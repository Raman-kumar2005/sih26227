"""
Part 5.2 — Embedding Change.

Calculates the z-score of an embedding's distance from its seasonal baseline.
"""
import numpy as np
import pandas as pd
from ml.change.baseline import get_season

def calculate_embedding_change(embeddings_df: pd.DataFrame, baselines_df: pd.DataFrame, vector_store) -> pd.DataFrame:
    """
    Computes embedding distance and z-score against seasonal baseline.
    """
    df = embeddings_df.copy()
    df['date'] = pd.to_datetime(df['date'])
    df['season'] = df['date'].dt.month.apply(get_season)
    df['tile_loc'] = df['aoi'] + '/' + df['tile_id'].apply(lambda x: x.split('/')[-1])
    
    # Merge baselines
    merged = pd.merge(df, baselines_df, on=['tile_loc', 'season'], how='left')
    
    distances = []
    zscores = []
    baseline_refs = []
    
    for idx, row in merged.iterrows():
        try:
            vec = vector_store.index.reconstruct(int(row['faiss_id']))
            median_vec = row['median_vec']
            spread = row['spread']
            
            if not isinstance(median_vec, np.ndarray):
                raise ValueError("No baseline")
                
            sim = np.dot(vec, median_vec)
            dist = 1.0 - sim
            z = (dist - 0.0) / spread  # using 0 as expected distance mean
            
            distances.append(dist)
            zscores.append(z)
            baseline_refs.append(f"{row['season']}_N={row['obs_count']}")
        except:
            distances.append(np.nan)
            zscores.append(np.nan)
            baseline_refs.append(None)
            
    df['embed_distance'] = distances
    df['embed_zscore'] = zscores
    df['baseline_ref'] = baseline_refs
    
    return df
