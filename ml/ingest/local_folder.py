import os
import glob
from typing import List, Tuple
from datetime import datetime
from .base import SourceAdapter, SceneMeta

class LocalFolderAdapter(SourceAdapter):
    def __init__(self, folder_path: str):
        self.folder_path = folder_path

    def list_scenes(self, aoi_name: str, bbox: Tuple[float, float, float, float], date_window: Tuple[str, str], max_items: int = 8) -> List[SceneMeta]:
        scenes = []
        # Mock logic to scan a folder for TIFs and extract fake metadata.
        # In a real offline demo, we would parse the actual GeoTIFF headers.
        if not os.path.exists(self.folder_path):
            return scenes
            
        for file in glob.glob(os.path.join(self.folder_path, "*.tif")):
            filename = os.path.basename(file)
            scenes.append(SceneMeta(
                scene_id=filename.split(".")[0],
                sensor="sentinel-2",
                platform="sentinel-2a",
                acquisition_datetime=datetime.now(), # Mock
                crs="EPSG:4326",
                bbox=bbox,
                cloud_pct=0.0,
                processing_level="L2A",
                source_url=file,
                licence="Proprietary/Local"
            ))
        return scenes

    def fetch(self, scene: SceneMeta, out_dir: str) -> str:
        # File is already local, just return the path
        return scene.source_url
