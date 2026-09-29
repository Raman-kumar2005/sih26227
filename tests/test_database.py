import pytest
from fastapi.testclient import TestClient
from backend.app.main import app
from backend.app.db.connection import get_db_status, is_postgis

client = TestClient(app)

def test_database_status():
    status = get_db_status()
    assert "engine" in status
    assert "mode" in status
    assert "spatial_indexing" in status

def test_health_endpoint_db_info():
    response = client.get("/api/health")
    assert response.status_code == 200
    data = response.json()
    assert data["status"] == "healthy"
    assert "database" in data
    assert "engine" in data["database"]

def test_system_status_endpoint():
    response = client.get("/api/system/status")
    assert response.status_code == 200
    data = response.json()
    assert data["air_gapped_mode"] is True
    assert "vector_index" in data
    assert "spatial_store" in data

def test_spatial_search_endpoint():
    response = client.get("/api/spatial/search?aoi=bangalore_lakes&min_confidence=0.1")
    assert response.status_code == 200
    data = response.json()
    assert "count" in data
    assert "engine" in data
    assert data["count"] > 0
