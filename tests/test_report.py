import pytest
from fastapi.testclient import TestClient
from backend.app.main import app

client = TestClient(app)

def test_download_change_dossier_pdf():
    response = client.get("/api/reports/pdf/delhi_airport/1_1_2026-09-04?aoi=delhi_airport&confidence=0.88")
    assert response.status_code == 200
    assert response.headers["content-type"] == "application/pdf"
    assert "attachment;" in response.headers["content-disposition"]
    assert len(response.content) > 10000 # Valid multi-page PDF with images
    # Verify PDF magic bytes
    assert response.content[:4] == b"%PDF"

def test_custom_dossier_pdf_post():
    payload = {
        "change_id": "bangalore_lakes/0_1_2026-09-04",
        "aoi": "bangalore_lakes",
        "confidence": 0.95,
        "change_type": "Wetland Incursion",
        "area_sqm": 35000.0,
        "analyst_name": "Dilip Raman",
        "clearance": "TOP SECRET // LEVEL 4"
    }
    response = client.post("/api/reports/generate-pdf", json=payload)
    assert response.status_code == 200
    assert response.headers["content-type"] == "application/pdf"
    assert response.content[:4] == b"%PDF"
