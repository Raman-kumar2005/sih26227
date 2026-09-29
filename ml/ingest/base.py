from abc import ABC, abstractmethod
from pydantic import BaseModel, Field
from typing import List, Tuple, Optional
from datetime import datetime

class SceneMeta(BaseModel):
    scene_id: str
    sensor: str
    platform: str
    acquisition_datetime: datetime
    crs: str
    bbox: Tuple[float, float, float, float]
    cloud_pct: float
    processing_level: str
    source_url: str
    licence: str

class SourceAdapter(ABC):
    @abstractmethod
    def list_scenes(self, aoi_name: str, bbox: Tuple[float, float, float, float], date_window: Tuple[str, str], max_items: int = 8) -> List[SceneMeta]:
        """List available scenes for a given AOI and time window."""
        pass

    @abstractmethod
    def fetch(self, scene: SceneMeta, out_dir: str) -> str:
        """Fetch the scene and return local path."""
        pass
