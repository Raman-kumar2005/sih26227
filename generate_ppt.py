from pptx import Presentation
from pptx.util import Inches, Pt
from pptx.enum.text import PP_ALIGN

prs = Presentation()

# Helper function to add a title and content slide
def add_slide(prs, title_text, bullet_points):
    slide_layout = prs.slide_layouts[1]
    slide = prs.slides.add_slide(slide_layout)
    title = slide.shapes.title
    title.text = title_text
    
    body_shape = slide.placeholders[1]
    tf = body_shape.text_frame
    tf.clear()
    
    for idx, pt in enumerate(bullet_points):
        p = tf.add_paragraph()
        if isinstance(pt, tuple): # Level 1
            p.text = pt[0]
            p.level = 1
        else:
            p.text = pt
            p.level = 0
            
    return slide

# Slide 1: Title Slide (SIH Format)
title_slide_layout = prs.slide_layouts[0]
slide = prs.slides.add_slide(title_slide_layout)
title = slide.shapes.title
subtitle = slide.placeholders[1]
title.text = "SIH26227: Multi-Temporal Satellite Image Analysis"
subtitle.text = "Team Name: [Your Team]\nInstitute: [Your Institute]\nTheme: Space Technology"

# Slide 2: Problem Statement & Proposed Solution
add_slide(prs, "Problem Statement & Proposed Solution", [
    "Problem: Intelligence analysts struggle to manually detect changes in massive satellite datasets.",
    "Proposed Solution: An Offline AI-driven Geospatial Search Engine.",
    ("Semantic search via FAISS instead of manual pixel matching.",),
    ("Mathematical suppression of False Alarms (clouds, snow, seasonal variance).",),
    ("100% offline and air-gapped capability for security.",)
])

# Slide 3: Technical Approach / Architecture
add_slide(prs, "Technical Approach / Architecture", [
    "Data Ingestion & Embedding:",
    ("Use ResNet18 proxy for Clay/SatMAE foundation models to encode satellite tiles.",),
    ("Vector indexing using FAISS for rapid retrieval.",),
    "Change Detection Module:",
    ("DeepLabV3 segmentation for morphological change masks (expansion/contraction).",),
    ("Automated confidence scoring penalizing environmental noise.",),
    "Frontend Workflow:",
    ("React/Vite dashboard with live/offline Map streaming (COG capability).",)
])

# Slide 4: Use Cases & Features
add_slide(prs, "Use Cases & Features", [
    "1. Semantic Text Search:",
    ("Query: 'newly built structures near a river'",),
    "2. Image-to-Image Search:",
    ("Upload a tile to find similar patterns globally.",),
    "3. Discovery and Clustering:",
    ("K-Means unsupervised clustering to group similar change events.",),
    "4. Analyst Workflow:",
    ("Interactive before/after swipe tool with approve/reject audit trails.",)
])

# Slide 5: Dependencies / Show Stoppers
add_slide(prs, "Dependencies / Show Stoppers", [
    "Dependencies:",
    ("Access to standardized Cloud Optimized GeoTIFF (COG) data.",),
    ("Minimum 4GB VRAM GPU for optimized Foundation Model inference.",),
    "Potential Show Stoppers:",
    ("Extremely heavy cloud cover obscuring ground truth (partially mitigated).",),
    ("Hardware failure in field deployment scenarios.",)
])

# Slide 6: Team Members
add_slide(prs, "Team Members", [
    "1. [Leader Name] - ML Architecture & Backend",
    "2. [Member 2] - React Frontend & UI/UX",
    "3. [Member 3] - Geospatial Data Pipeline",
    "4. [Member 4] - Testing & QA",
    "5. [Member 5] - Presentation & Documentation",
    "6. [Member 6] - Hardware / Integration"
])

prs.save("SIH_Internal_Presentation.pptx")
print("SIH formatted presentation generated successfully.")
