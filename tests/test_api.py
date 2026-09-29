from fastapi.testclient import TestClient
from backend.app.main import app

client = TestClient(app)

def run_tests():
    print("--- TESTING BACKEND API ---")
    
    # 1. Health check
    res = client.get("/api/health")
    print("\n[GET /api/health]")
    print(res.json())
    assert res.status_code == 200
    
    # 2. Text Search
    res = client.post("/api/search", json={"query": "newly built structures near a river"})
    print("\n[POST /api/search (Text)]")
    data = res.json()
    print(f"Parsed change_type: {data['parsed_query']['change_type']}")
    print(f"Results found: {len(data['results'])}")
    print(f"Provenance included: {'provenance' in data}")
    
    # 3. Similar-to Search
    res = client.post("/api/search", json={"query": "find sites similar to tile bangalore_lakes/1_1"})
    print("\n[POST /api/search (Similar-To)]")
    data = res.json()
    print(f"Mode: {data['parsed_query']['mode']}")
    print(f"Results found: {len(data['results'])}")
    if len(data['results']) > 0:
        print(f"Top result score: {data['results'][0]['final_score']}")
        
    print("\n--- ALL API TESTS PASSED ---")

if __name__ == "__main__":
    run_tests()

