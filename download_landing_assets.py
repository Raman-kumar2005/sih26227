import urllib.request
import ssl
import os

os.makedirs('frontend/public/images', exist_ok=True)

ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

headers = {'User-Agent': 'Mozilla/5.0'}

# Unsplash satellite & aerial images with high aesthetic matching the storyboard
images = {
    # Construction Phasing (t1 to t4)
    "phase_t1.jpg": "https://images.unsplash.com/photo-1541888946425-d0fbb186156a?w=600&auto=format&fit=crop", # ground excavation
    "phase_t2.jpg": "https://images.unsplash.com/photo-1504307651254-35680f356dfd?w=600&auto=format&fit=crop", # framing / concrete
    "phase_t3.jpg": "https://images.unsplash.com/photo-1590381105924-c72589b9ef3f?w=600&auto=format&fit=crop", # structural rise
    "phase_t4.jpg": "https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=600&auto=format&fit=crop", # modern completed facility
    
    # Seasonal suppression
    "snow_cover.jpg": "https://images.unsplash.com/photo-1517030330234-94c4fb948ebc?w=600&auto=format&fit=crop", # snowy road/landscape aerial
    "summer_green.jpg": "https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=600&auto=format&fit=crop", # lush green farmland/valley
    "complex_facility.jpg": "https://images.unsplash.com/photo-1577083552431-6e5fd01aa342?w=800&auto=format&fit=crop", # top-down facility
    
    # 4 Solutions (Before & After)
    # 1. National Security
    "security_before.jpg": "https://images.unsplash.com/photo-1508614589041-895b88991e3e?w=500&auto=format&fit=crop", # industrial/depot ground
    "security_after.jpg": "https://images.unsplash.com/photo-1579783900882-c0d3dad7b119?w=500&auto=format&fit=crop", # hangar/tarmac top down
    
    # 2. Urban Planning
    "urban_before.jpg": "https://images.unsplash.com/photo-1477959858617-67f30bc75b82?w=500&auto=format&fit=crop", # open terrain grid
    "urban_after.jpg": "https://images.unsplash.com/photo-1519501025264-65ba15a82390?w=500&auto=format&fit=crop", # residential grid development
    
    # 3. Environmental Science
    "env_before.jpg": "https://images.unsplash.com/photo-1448375240586-882707db888b?w=500&auto=format&fit=crop", # river meander through greenery
    "env_after.jpg": "https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?w=500&auto=format&fit=crop", # dried/altered riverbed
    
    # 4. Infrastructure Management
    "infra_before.jpg": "https://images.unsplash.com/photo-1513836279014-a89f7a76ae86?w=500&auto=format&fit=crop", # dam/bridge waterway
    "infra_after.jpg": "https://images.unsplash.com/photo-1545558014-8692077e9b5c?w=500&auto=format&fit=crop", # bridge/highway viaduct
}

print("Downloading authentic visual assets...")
for name, url in images.items():
    dest = os.path.join('frontend', 'public', 'images', name)
    try:
        req = urllib.request.Request(url, headers=headers)
        with urllib.request.urlopen(req, context=ctx) as resp, open(dest, 'wb') as f:
            f.write(resp.read())
        print(f"✓ Saved {name}")
    except Exception as e:
        print(f"✗ Failed {name}: {e}")

print("Assets ready!")
