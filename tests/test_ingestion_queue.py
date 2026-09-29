import pytest
import time
from fastapi.testclient import TestClient
from backend.app.main import app

client = TestClient(app)

def test_get_sample_scenes():
    response = client.get("/api/ingest/sample_scenes")
    assert response.status_code == 200
    data = response.json()
    assert "scenes" in data
    assert len(data["scenes"]) >= 3

def test_submit_ingest_job_and_poll_status():
    # Submit job
    payload = {
        "scene_name": "Test_Sentinel2_Pass",
        "aoi": "delhi_airport",
        "file_path": None
    }
    response = client.post("/api/ingest/submit", json=payload)
    assert response.status_code == 200
    data = response.json()
    assert data["status"] == "QUEUED"
    assert "job_id" in data
    job_id = data["job_id"]

    # Poll status immediately
    status_resp = client.get(f"/api/ingest/status/{job_id}")
    assert status_resp.status_code == 200
    status_data = status_resp.json()
    assert status_data["job_id"] == job_id
    assert status_data["status"] in ["QUEUED", "PROCESSING", "TILING", "COMPLETED"]

def test_list_recent_jobs():
    response = client.get("/api/ingest/jobs")
    assert response.status_code == 200
    data = response.json()
    assert "jobs" in data
    assert isinstance(data["jobs"], list)
