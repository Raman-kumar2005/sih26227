import requests
import json
import os

STAC_URL = "https://earth-search.aws.element84.com/v1/search"

# Kashmir border approximate bbox [min_lon, min_lat, max_lon, max_lat]
bbox = [73.8, 34.0, 75.2, 34.8]

payload = {
    "bbox": bbox,
    "collections": ["sentinel-2-l2a"],
    "datetime": "2023-09-01T00:00:00Z/2023-10-31T23:59:59Z", # Clear season
    "limit": 1,
    "query": {
        "eo:cloud_cover": {"lt": 5} # Less than 5% clouds
    }
}

print("Searching Earth Search AWS STAC...")
response = requests.post(STAC_URL, json=payload)
data = response.json()

if not data.get("features"):
    print("No images found.")
else:
    feature = data["features"][0]
    print(f"Found Image ID: {feature['id']}")
    print(f"Date: {feature['properties']['datetime']}")
    
    # Get the True Color visual image (TCI)
    assets = feature["assets"]
    visual_asset = assets.get("visual")
    
    if visual_asset:
        download_url = visual_asset["href"]
        print(f"Downloading from: {download_url}")
        
        # Download the file
        img_response = requests.get(download_url, stream=True)
        save_path = os.path.join("data", "kashmir_border_sentinel2.tif")
        
        with open(save_path, "wb") as f:
            for chunk in img_response.iter_content(chunk_size=8192):
                f.write(chunk)
                
        print(f"Success! Saved to {save_path}")
    else:
        print("Visual asset not available for this tile.")
