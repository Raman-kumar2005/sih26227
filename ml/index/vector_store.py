"""
Part 4.3 — FAISS Vector Store.

FAISS IndexIDMap2 wrapping IndexFlatIP over L2-normalised vectors.
Supports add, search, save, and load. Incremental add is supported.
"""
import os
import faiss
import numpy as np
from typing import List, Tuple, Optional


class VectorStore:
    def __init__(self, dim: int = 768):
        self.dim = dim
        self.index_path = None
        # IndexFlatIP calculates inner product, which is cosine similarity for L2-normalized vectors
        self._base_index = faiss.IndexFlatIP(dim)
        # IDMap2 allows us to map string/custom integer IDs to vectors
        self.index = faiss.IndexIDMap2(self._base_index)

    @property
    def ntotal(self) -> int:
        return self.index.ntotal

    def add(self, ids: np.ndarray, vectors: np.ndarray):
        """
        Incrementally add vectors to the index.
        Args:
            ids: 1D int64 numpy array of IDs
            vectors: (N, D) float32 numpy array, L2-normalized
        """
        assert vectors.shape[1] == self.dim, f"Expected dim {self.dim}, got {vectors.shape[1]}"
        assert len(ids) == len(vectors), "ids and vectors must have the same length"
        
        self.index.add_with_ids(vectors.astype(np.float32), ids.astype(np.int64))

    def search(self, query_vector: np.ndarray, k: int, subset_ids: Optional[np.ndarray] = None) -> Tuple[np.ndarray, np.ndarray]:
        """
        Search the index for the top-k most similar vectors.
        Args:
            query_vector: (1, D) float32 numpy array, L2-normalized
            k: number of results to return
            subset_ids: 1D int64 array of IDs to restrict the search to
        Returns:
            distances: (1, k) float32 numpy array
            ids: (1, k) int64 numpy array
        """
        # If subset_ids is provided, use IDSelectorBatch
        if subset_ids is not None and len(subset_ids) > 0:
            selector = faiss.IDSelectorBatch(subset_ids.astype(np.int64).tolist())
            search_params = faiss.SearchParametersIVF(sel=selector)
            
            # Since IndexFlatIP doesn't use IVF parameters natively for filtering in all versions, 
            # we can filter the subset manually or use IDSelector if supported by the version.
            # IDMap doesn't easily support sel directly in flat search.
            # A robust fallback for exact search with subset:
            # Reconstruct vectors for subset_ids and compute dot product manually, OR
            # build a temporary sub-index. Given small data size for typical filters, manual is fine,
            # or we fetch results and post-filter (but we might not get k results).
            # To strictly support search over subset with FAISS flat index:
            try:
                # Some newer FAISS versions support sel for flat indices via search_params
                dist, idx = self.index.search(query_vector.astype(np.float32), k, params=search_params)
                return dist, idx
            except Exception:
                pass
                
            # Fallback: Extract vectors for subset_ids and do manual inner product
            # In IDMap2, we can reconstruct the vectors
            subset_ids = subset_ids.astype(np.int64)
            subset_vecs = np.zeros((len(subset_ids), self.dim), dtype=np.float32)
            for i, _id in enumerate(subset_ids):
                try:
                    subset_vecs[i] = self.index.reconstruct(_id)
                except Exception:
                    pass # ID not found
            
            # Dot product
            scores = np.dot(subset_vecs, query_vector.T).flatten()
            
            # Top k
            top_k_idx = np.argsort(scores)[::-1][:k]
            
            return scores[top_k_idx].reshape(1, -1), subset_ids[top_k_idx].reshape(1, -1)
            
        return self.index.search(query_vector.astype(np.float32), k)

    def save(self, path: str):
        """Save index to disk."""
        os.makedirs(os.path.dirname(path), exist_ok=True)
        faiss.write_index(self.index, path)
        self.index_path = path

    def load(self, path: str):
        """Load index from disk."""
        if os.path.exists(path):
            self.index = faiss.read_index(path)
            self.dim = self.index.d
            self.index_path = path
        else:
            raise FileNotFoundError(f"FAISS index not found at {path}")
