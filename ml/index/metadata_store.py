"""
Part 4.4 — Metadata Store.

GeoParquet (or just Parquet) for tile and scene metadata.
ALL filtering happens here BEFORE vector search.
"""
import os
import pandas as pd
import numpy as np
from typing import List, Dict, Any, Optional
import hashlib

class MetadataStore:
    def __init__(self, path: str = "data/index/metadata.parquet"):
        self.path = path
        self.df = None
        self._int_id_map = {}  # Map string tile_id to int64 for FAISS
        self._rev_id_map = {}
        if os.path.exists(path):
            self.load()

    def load(self):
        self.df = pd.read_parquet(self.path)
        self._build_id_map()
        
    def _build_id_map(self):
        """Build deterministic int64 IDs for FAISS from string tile_ids."""
        for _, row in self.df.iterrows():
            tid = row['tile_id']
            # Stable integer hash
            hash_int = int(hashlib.md5(tid.encode('utf-8')).hexdigest()[:15], 16)
            self._int_id_map[tid] = hash_int
            self._rev_id_map[hash_int] = tid

    def build_from_tiles(self, tiles_parquet_path: str):
        """Initialize metadata store from tiles.parquet."""
        self.df = pd.read_parquet(tiles_parquet_path)
        # Ensure we have a deterministic faiss_id column
        self._build_id_map()
        self.df['faiss_id'] = self.df['tile_id'].map(self._int_id_map)
        
        os.makedirs(os.path.dirname(self.path), exist_ok=True)
        self.df.to_parquet(self.path, index=False)

    def filter_ids(self, 
                   aoi: Optional[str] = None,
                   date_start: Optional[str] = None,
                   date_end: Optional[str] = None,
                   sensor: Optional[str] = None,
                   min_usable_fraction: float = 0.0) -> np.ndarray:
        """
        Filter tiles based on criteria and return their int64 FAISS IDs.
        """
        if self.df is None:
            return np.array([], dtype=np.int64)
            
        mask = np.ones(len(self.df), dtype=bool)
        
        if aoi:
            mask &= (self.df['aoi'] == aoi)
            
        if date_start:
            mask &= (self.df['date'] >= pd.to_datetime(date_start))
            
        if date_end:
            mask &= (self.df['date'] <= pd.to_datetime(date_end))
            
        if sensor:
            mask &= (self.df['sensor'] == sensor)
            
        if 'usable_fraction' in self.df.columns and min_usable_fraction > 0:
            mask &= (self.df['usable_fraction'] >= min_usable_fraction)
            
        filtered = self.df[mask]
        return filtered['faiss_id'].values.astype(np.int64)

    def get_tile_info(self, faiss_id: int) -> Dict[str, Any]:
        """Get full metadata for a given FAISS ID."""
        if self.df is None or faiss_id not in self._rev_id_map:
            return {}
        
        tid = self._rev_id_map[faiss_id]
        row = self.df[self.df['tile_id'] == tid].iloc[0]
        return row.to_dict()

    def get_faiss_id(self, tile_id: str) -> int:
        return self._int_id_map.get(tile_id, -1)
        
    def get_tile_id(self, faiss_id: int) -> str:
        return self._rev_id_map.get(faiss_id, "")
