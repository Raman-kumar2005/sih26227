import pandas as pd
import numpy as np
import pytest
from datetime import datetime

from ml.change.confidence import (
    score_quality,
    score_registration,
    score_seasonal,
    score_radiometric,
    check_persistence,
    check_sar,
    compute_confidence_stack
)

def test_score_quality():
    assert score_quality(1.0) == 1.0
    assert score_quality(0.5) == 0.5
    assert score_quality(1.5) == 1.0
    assert score_quality(-0.1) == 0.0

def test_score_registration():
    assert score_registration(0.0) == 1.0
    assert score_registration(0.5) == 0.5
    assert score_registration(1.2) == 0.0

def test_score_seasonal():
    assert score_seasonal(np.nan) == 0.0
    # z=2 -> 0.5
    assert abs(score_seasonal(2.0) - 0.5) < 0.01
    # z=4 -> high
    assert score_seasonal(4.0) > 0.8
    # z=0 -> low
    assert score_seasonal(0.0) < 0.2

def test_score_radiometric():
    assert score_radiometric() == 1.0

def test_check_persistence():
    df = pd.DataFrame({
        'tile_id': ['t1', 't1', 't1', 't1'],
        'date': pd.to_datetime(['2024-01-01', '2024-01-10', '2024-01-20', '2024-01-30']),
        'usable_fraction': [1.0, 1.0, 0.5, 1.0], # 3rd is unusable
        'embed_zscore': [3.0, 2.5, 0.0, 2.1]
    })
    
    # Test 1: from Jan 1, next usable are Jan 10 (z=2.5) and Jan 30 (z=2.1)
    res = check_persistence('t1', pd.to_datetime('2024-01-01'), df)
    assert res['score'] == 1.0
    assert res['status'] == 'confirmed_persistent'
    
    # Test 2: from Jan 10, only one usable future observation (Jan 30)
    res = check_persistence('t1', pd.to_datetime('2024-01-10'), df)
    assert res['score'] == 0.5
    assert res['status'] == 'unknown_insufficient_obs'

def test_check_sar():
    assert check_sar() == 0.0

def test_compute_confidence_stack(tmp_path):
    # Mock config
    config_content = """
    confidence_weights:
      quality: 0.2
      registration: 0.2
      seasonal: 0.2
      radiometric: 0.0
      persistence: 0.4
      sar_corroboration: 0.0
    """
    config_file = tmp_path / "settings.yaml"
    config_file.write_text(config_content)
    
    df = pd.DataFrame({
        'change_id': ['c1'],
        'tile_id': ['t1'],
        'date': pd.to_datetime(['2024-01-01']),
        'usable_fraction': [1.0],
        'coreg_residual': [0.0],
        'embed_zscore': [2.0], # seasonal score = 0.5
    })
    
    out = compute_confidence_stack(df, str(config_file))
    
    # Expected: 
    # q=1.0 * 0.2 = 0.2
    # reg=1.0 * 0.2 = 0.2
    # seas=0.5 * 0.2 = 0.1
    # pers=0.5 (insufficient) * 0.4 = 0.2
    # total = 0.7
    assert len(out) == 1
    assert 'confidence' in out.columns
    assert 'confidence_breakdown' in out.columns
    assert abs(out.iloc[0]['confidence'] - 0.7) < 0.01
    assert out.iloc[0]['confidence_breakdown']['sar'] == 'unavailable'

