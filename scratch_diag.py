import requests

queries = [
    'construction area near arunchal pradesh',
    'vegetation clearance in forest area',
    'water body shrinkage 2024'
]
for q in queries:
    r = requests.post('http://127.0.0.1:8000/api/search', json={'query': q})
    data = r.json()
    tiles = [res['tile_id'] for res in data['results'][:3]]
    print("Query:", q[:45])
    print("  change_type:", data['parsed_query']['change_type'])
    print("  top 3 tiles:", tiles)
    print()

