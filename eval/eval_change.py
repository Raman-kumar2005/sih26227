"""
Docstring for eval_change.py.
"""
import pandas as pd
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import os

def run_change_eval():
    print("--- EVALUATING CHANGE ENGINE (Precision/Recall Curve) ---")
    
    # We load the scored changes. Since we don't have real ground truth labels for every tile in the dummy data,
    # we will use the 'embed_zscore' > 3.0 as a proxy for "True Change" to demonstrate the curve generation mechanism.
    # In a real scenario, there would be a hand-labeled set of change/no-change tiles.
    
    df = pd.read_parquet("data/index/changes_scored.parquet")
    
    # Proxy ground truth: Z-score > 3.0 is a true change.
    df['is_true_change'] = df['embed_zscore'] > 3.0
    
    thresholds = [0.1, 0.3, 0.5, 0.7, 0.9]
    results = []
    
    for t in thresholds:
        predicted = df['confidence'] >= t
        actual = df['is_true_change']
        
        tp = np.sum(predicted & actual)
        fp = np.sum(predicted & ~actual)
        fn = np.sum(~predicted & actual)
        tn = np.sum(~predicted & ~actual)
        
        precision = tp / (tp + fp) if (tp + fp) > 0 else 1.0
        recall = tp / (tp + fn) if (tp + fn) > 0 else 0.0
        f1 = 2 * (precision * recall) / (precision + recall) if (precision + recall) > 0 else 0.0
        fpr = fp / (fp + tn) if (fp + tn) > 0 else 0.0
        
        results.append({
            'threshold': t,
            'precision': precision,
            'recall': recall,
            'f1': f1,
            'fpr': fpr
        })
        
    print(pd.DataFrame(results))
    
    # Generate ASCII Plot
    print("\nASCII Precision-Recall Curve:")
    for r in results:
        print(f"Thresh {r['threshold']:.1f}: P={r['precision']:.2f} R={r['recall']:.2f} " + "="*int(r['precision']*20))
    
    # Append to markdown
    os.makedirs("docs", exist_ok=True)
    with open("docs/EVALUATION.md", "a") as f:
        f.write("\n## Change Detection Evaluation\n")
        f.write("| Threshold | Precision | Recall | F1 Score | False Positive Rate |\n")
        f.write("|---|---|---|---|---|\n")
        for r in results:
            f.write(f"| {r['threshold']:.1f} | {r['precision']:.3f} | {r['recall']:.3f} | {r['f1']:.3f} | {r['fpr']:.3f} |\n")
            
    print("Logged to docs/EVALUATION.md")

if __name__ == "__main__":
    run_change_eval()
