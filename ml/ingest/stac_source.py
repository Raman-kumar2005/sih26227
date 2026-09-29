import os
import httpx
from typing import List, Tuple
from datetime import datetime
from .base import SourceAdapter, SceneMeta

class EarthSearchSTACAdapter(SourceAdapter):
    STAC_URL = "https://earth-search.aws.element84.com/v1/search"
    COLLECTION = "sentinel-2-l2a"

    def list_scenes(self, aoi_name: str, bbox: Tuple[float, float, float, float], date_window: Tuple[str, str], max_items: int = 8) -> List[SceneMeta]:
        time_range = f"{date_window[0]}T00:00:00Z/{date_window[1]}T23:59:59Z"
        
        payload = {
            "collections": [self.COLLECTION],
            "bbox": list(bbox),
            "datetime": time_range,
            "limit": 100,
            "query": {
                "eo:cloud_cover": {"lt": 20}
            }
        }
        
        response = httpx.post(self.STAC_URL, json=payload, timeout=30.0)
        response.raise_for_status()
        data = response.json()
        
        features = data.get("features", [])
        
        # Simple seasonal sampling (approx 2 per season)
        # For a robust implementation, we sort by cloud cover and take top `max_items`
        # or implement specific seasonal buckets.
        features = sorted(features, key=lambda x: x["properties"].get("eo:cloud_cover", 100))
        selected_features = features[:max_items]
        
        scenes = []
        for feat in selected_features:
            props = feat["properties"]
            # Check for B02, B03, B04, B08, B11, B12, SCL
            assets = feat["assets"]
            
            # Earth Search usually provides COGs via href
            # We will use visual as source_url or specifically collect band URLs during fetch
            source_url = assets.get("visual", {}).get("href", "")
            if not source_url:
                source_url = assets.get("B04", {}).get("href", "")
                
            scenes.append(SceneMeta(
                scene_id=feat["id"],
                sensor="sentinel-2",
                platform=props.get("platform", "sentinel-2"),
                acquisition_datetime=datetime.fromisoformat(props["datetime"].replace('Z', '+00:00')),
                crs=f"EPSG:{props.get('proj:epsg', '4326')}",
                bbox=tuple(feat["bbox"]),
                cloud_pct=props.get("eo:cloud_cover", 0.0),
                processing_level="L2A",
                source_url=source_url, # Will store the base/visual URL
                licence="CC-BY-4.0"
            ))
        return scenes

    def fetch(self, scene: SceneMeta, out_dir: str) -> str:
        import requests
        
        local_path = os.path.join(out_dir, f"{scene.scene_id}.tif")
        if os.path.exists(local_path):
            return local_path
            
        print(f"Fetching {scene.scene_id} ...", flush=True)
        response = requests.get(scene.source_url, stream=True, timeout=30.0)
        response.raise_for_status()
        
        with open(local_path, "wb") as f:
            for chunk in response.iter_content(chunk_size=8192):
                f.write(chunk)
                
        print(f"Downloaded {scene.scene_id} to {local_path}", flush=True)
        return local_path
