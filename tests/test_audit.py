import pytest
from fastapi.testclient import TestClient
from backend.app.main import app

client = TestClient(app)

def test_get_audit_logs():
    response = client.get("/api/audit/logs")
    assert response.status_code == 200
    data = response.json()
    assert "logs" in data
    assert len(data["logs"]) > 0
    first_log = data["logs"][0]
    assert "action" in first_log
    assert "clearance_level" in first_log

def test_get_audit_stats():
    response = client.get("/api/audit/stats")
    assert response.status_code == 200
    data = response.json()
    assert "stats" in data
    assert "total_audit_events" in data["stats"]
    assert "security_compliance" in data["stats"]

def test_create_audit_entry():
    payload = {
        "user_email": "analyst@changetracker.gov.in",
        "clearance_level": "TOP SECRET // LEVEL 4",
        "action": "TEST_UNIT_ACTION",
        "endpoint": "/api/test",
        "details": {"test": True}
    }
    response = client.post("/api/audit/log", json=payload)
    assert response.status_code == 200
    data = response.json()
    assert data["status"] == "success"
    assert "event_id" in data

def test_export_defense_geojson():
    response = client.get("/api/audit/export/geojson")
    assert response.status_code == 200
    data = response.json()
    assert data["type"] == "FeatureCollection"
    assert "defense_metadata" in data
    assert "air_gap_integrity_sha256" in data["defense_metadata"]
    assert len(data["features"]) > 0

def test_export_mission_summary():
    response = client.get("/api/audit/export/summary")
    assert response.status_code == 200
    data = response.json()
    assert "mission_code" in data
    assert "operational_theater" in data
    assert "analyst_sign_off" in data
