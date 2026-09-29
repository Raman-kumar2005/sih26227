"""
Part 6 — Confidence Stack (2.2.3).

Implements independent, unit-testable factors that compose the final confidence score.
Favour analytically useful precision over indiscriminate change recall.
"""
import numpy as np
import pandas as pd
import yaml
import os
from typing import Dict, Any

def score_quality(usable_fraction: float) -> float:
    """Quality gate: penalise low usable fraction."""
    # If perfect, score 1.0. Drops off linearly below 1.0.
    return max(0.0, min(1.0, usable_fraction))

def score_registration(coreg_residual: float) -> float:
    """Registration penalty: penalise high sub-pixel shifts."""
    # 0 pixels = 1.0. If shift is >= 1 pixel, score drops to 0.0
    return max(0.0, 1.0 - coreg_residual)

def score_seasonal(embed_zscore: float) -> float:
    """Seasonal deviation: z-score against seasonal baseline."""
    # Sigmoid-like scaling: z=0 -> 0.0, z=2 -> 0.5, z=4 -> 0.9+
    # A z-score of 3.0 is a strong signal.
    if pd.isna(embed_zscore):
        return 0.0
    return max(0.0, min(1.0, 1.0 / (1.0 + np.exp(-(embed_zscore - 2.0)))))

def score_radiometric() -> float:
    """Radiometric consistency (Placeholder)."""
    # Without atmospheric correction metrics, we default to 1.0 
    # to not penalise randomly.
    return 1.0

def check_persistence(tile_id: str, current_date: pd.Timestamp, df: pd.DataFrame) -> Dict[str, Any]:
    """
    Persistence Check: Real change persists at t+1 and t+2.
    Requires signal to hold across at least 2 subsequent USABLE observations.
    
    If no usable subsequent observations exist, we return a score of 0.5 (Unknown/Neutral),
    not 1.0 (Confirmed) nor 0.0 (Refuted).
    """
    loc_df = df[(df['tile_id'] == tile_id) & (df['date'] > current_date)].sort_values('date')
    
    # Filter to usable observations
    usable_future = loc_df[loc_df['usable_fraction'] >= 0.80]
    
    if len(usable_future) < 2:
        return {
            'score': 0.5, 
            'count': len(usable_future), 
            'status': "unknown_insufficient_obs"
        }
    
    # Check if the next 2 observations maintain a high z-score (>2.0)
    z1 = usable_future.iloc[0]['embed_zscore']
    z2 = usable_future.iloc[1]['embed_zscore']
    
    if pd.isna(z1) or pd.isna(z2):
        return {'score': 0.5, 'count': 2, 'status': "unknown_nulls"}
        
    if z1 > 2.0 and z2 > 2.0:
        return {'score': 1.0, 'count': 2, 'status': "confirmed_persistent"}
    elif z1 > 2.0 or z2 > 2.0:
        return {'score': 0.5, 'count': 2, 'status': "partially_persistent"}
    else:
        return {'score': 0.0, 'count': 2, 'status': "transient_artefact"}

def check_sar() -> float:
    """
    SAR Corroboration.
    Returns 'unavailable' flag essentially. We score it 0.0 and zero out its weight in config.
    """
    # Sentinel-1 is not ingested. Do not fake it.
    return 0.0

def compute_confidence_stack(changes_df: pd.DataFrame, config_path: str = "config/settings.yaml") -> pd.DataFrame:
    """
    Computes the full confidence stack for all changes.
    """
    with open(config_path, 'r') as f:
        config = yaml.safe_load(f)
    weights = config.get('confidence_weights', {})
    
    w_q = weights.get('quality', 0.15)
    w_reg = weights.get('registration', 0.15)
    w_seas = weights.get('seasonal', 0.30)
    w_rad = weights.get('radiometric', 0.05)
    w_pers = weights.get('persistence', 0.35)
    w_sar = weights.get('sar_corroboration', 0.0)
    
    # Normalize weights just in case
    total_w = w_q + w_reg + w_seas + w_rad + w_pers + w_sar
    
    out = changes_df.copy()
    out['date'] = pd.to_datetime(out['date'])
    
    scores = []
    breakdowns = []
    
    for _, row in out.iterrows():
        s_q = score_quality(row['usable_fraction'])
        s_reg = score_registration(row['coreg_residual'])
        s_seas = score_seasonal(row['embed_zscore'])
        s_rad = score_radiometric()
        
        pers_res = check_persistence(row['tile_id'], row['date'], out)
        s_pers = pers_res['score']
        
        s_sar = check_sar()
        
        final_score = (
            w_q * s_q + 
            w_reg * s_reg + 
            w_seas * s_seas + 
            w_rad * s_rad + 
            w_pers * s_pers + 
            w_sar * s_sar
        ) / total_w
        
        breakdown = {
            'quality': round(s_q, 3),
            'registration': round(s_reg, 3),
            'seasonal': round(s_seas, 3),
            'radiometric': round(s_rad, 3),
            'persistence': round(s_pers, 3),
            'persistence_status': pers_res['status'],
            'sar': 'unavailable'
        }
        
        scores.append(round(final_score, 3))
        breakdowns.append(breakdown)
        
    out['confidence'] = scores
    out['confidence_breakdown'] = breakdowns
    return out
