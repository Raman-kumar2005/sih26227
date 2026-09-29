from pydantic import BaseModel, Field
from typing import Literal, Optional, List, Tuple
from datetime import date

class ParsedQuery(BaseModel):
    mode: Literal["text", "similar_to", "image_upload"] = Field(
        default="text",
        description="Search mode. 'similar_to' if user mentions 'similar to tile X'."
    )
    text: Optional[str] = Field(
        default=None,
        description="The core descriptive text/keywords from the query."
    )
    seed_tile_id: Optional[str] = Field(
        default=None,
        description="Tile ID if the user wants similar items."
    )
    change_type: Literal["construction", "clearance", "water_extent", "road_development", "any"] = Field(
        default="any",
        description="Broad category of change detected in the query."
    )
    t_start: Optional[date] = Field(
        default=None,
        description="Start date mentioned (if any)."
    )
    t_end: Optional[date] = Field(
        default=None,
        description="End date mentioned (if any)."
    )
    aoi: Optional[str] = Field(
        default=None,
        description="Area of Interest mentioned."
    )
    bbox: Optional[Tuple[float, float, float, float]] = Field(
        default=None,
        description="Bounding box if coordinates provided."
    )
    sensors: List[str] = Field(
        default_factory=list,
        description="Requested sensors like Sentinel-1, Sentinel-2."
    )
    min_confidence: float = Field(
        default=0.5,
        description="Minimum confidence threshold. Usually 0.5 unless strictness is mentioned."
    )
    top_k: int = Field(
        default=10,
        description="Number of results to return."
    )

