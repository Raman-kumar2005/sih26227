"""
Docstring for eval_retrieval.py.
"""
import yaml
import os
import requests
import numpy as np

def run_retrieval_eval():
    with open("eval/queries.yaml", "r") as f:
        data = yaml.safe_load(f)
        
    queries = data.get("queries", [])
    
    # Check if blocked
    blocked = False
    for q in queries:
        if not q.get("expected_tile_ids"):
            blocked = True
            break
            
    if blocked:
        print("BLOCKED: Ground truth expected_tile_ids are missing in eval/queries.yaml.")
        print("Please label the expected tile IDs before running this evaluation.")
        return
        
    print("--- EVALUATING RETRIEVAL (Precision@5, MRR) ---")
    
    p5_scores = []
    mrr_scores = []
    
    for q in queries:
        text = q['text']
        expected = set(q['expected_tile_ids'])
        
        # Hit the API
        res = requests.post("http://127.0.0.1:8000/api/search", json={"query": text})
        results = res.json().get("results", [])
        
        retrieved_tiles = [r['tile_id'] for r in results]
        
        # Precision@5
        top_5 = retrieved_tiles[:5]
        hits = sum(1 for t in top_5 if t in expected)
        p5 = hits / 5.0 if expected else 0.0
        p5_scores.append(p5)
        
        # MRR
        mrr = 0.0
        for idx, t in enumerate(retrieved_tiles):
            if t in expected:
                mrr = 1.0 / (idx + 1)
                break
        mrr_scores.append(mrr)
        
        print(f"Q: {text[:30]}... | P@5: {p5:.2f} | MRR: {mrr:.2f}")
        
    mean_p5 = np.mean(p5_scores)
    mean_mrr = np.mean(mrr_scores)
    
    print("\n--- AGGREGATE SCORES ---")
    print(f"Mean Precision@5 : {mean_p5:.3f}")
    print(f"Mean Reciprocal Rank : {mean_mrr:.3f}")
    
    # Append to markdown
    os.makedirs("docs", exist_ok=True)
    with open("docs/EVALUATION.md", "a") as f:
        f.write("\n## Retrieval Evaluation\n")
        f.write("| Metric | Score |\n|---|---|\n")
        f.write(f"| Precision@5 | {mean_p5:.3f} |\n")
        f.write(f"| Mean Reciprocal Rank (MRR) | {mean_mrr:.3f} |\n")
        
    print("Logged to docs/EVALUATION.md")

if __name__ == "__main__":
    run_retrieval_eval()
