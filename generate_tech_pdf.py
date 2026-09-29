from reportlab.lib.pagesizes import letter
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, PageBreak, ListFlowable, ListItem
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.lib.enums import TA_JUSTIFY, TA_LEFT

def generate_pdf(filename="Tech_Stack_Explanation.pdf"):
    doc = SimpleDocTemplate(filename, pagesize=letter, rightMargin=72, leftMargin=72, topMargin=72, bottomMargin=18)
    
    styles = getSampleStyleSheet()
    styles.add(ParagraphStyle(name='Justify', alignment=TA_JUSTIFY))
    title_style = styles['Title']
    heading_style = styles['Heading2']
    subheading_style = styles['Heading3']
    normal_style = styles['Normal']
    
    Story = []
    
    # Title
    Story.append(Paragraph("SIH26227: Technical Stack & Library Breakdown", title_style))
    Story.append(Paragraph("A complete guide for presentation defense.", normal_style))
    Story.append(Spacer(1, 24))
    
    # Intro
    Story.append(Paragraph("If judges ask you what technologies were used and WHY they were used, use this document to answer confidently. Our architecture is split into Frontend, Backend, Machine Learning, and Databases.", normal_style))
    Story.append(Spacer(1, 24))
    
    # 1. FRONTEND
    Story.append(Paragraph("1. Frontend (User Interface)", heading_style))
    Story.append(Spacer(1, 12))
    
    Story.append(Paragraph("<b>React.js</b>", subheading_style))
    Story.append(Paragraph("What it is: A JavaScript library for building user interfaces.<br/>Why we used it: It allows us to build the map dashboard, image swipe tool, and search bar as reusable components. It makes the UI highly interactive without refreshing the page.", normal_style))
    Story.append(Spacer(1, 8))
    
    Story.append(Paragraph("<b>TypeScript</b>", subheading_style))
    Story.append(Paragraph("What it is: A strongly typed version of JavaScript.<br/>Why we used it: It prevents bugs during development by catching errors early (e.g., ensuring coordinates are numbers, not text).", normal_style))
    Story.append(Spacer(1, 8))
    
    Story.append(Paragraph("<b>Vite</b>", subheading_style))
    Story.append(Paragraph("What it is: A modern, lightning-fast build tool for web apps.<br/>Why we used it: It compiles our React code instantly, making development much faster than older tools like Webpack.", normal_style))
    Story.append(Spacer(1, 8))
    
    Story.append(Paragraph("<b>Tailwind CSS</b>", subheading_style))
    Story.append(Paragraph("What it is: A utility-first CSS framework.<br/>Why we used it: Instead of writing thousands of lines of custom CSS, we use Tailwind classes (like 'bg-blue-500') to style our app directly inside the HTML, saving massive amounts of time.", normal_style))
    Story.append(Spacer(1, 24))
    
    # 2. BACKEND
    Story.append(Paragraph("2. Backend (Server & APIs)", heading_style))
    Story.append(Spacer(1, 12))
    
    Story.append(Paragraph("<b>Python</b>", subheading_style))
    Story.append(Paragraph("What it is: The core programming language of our backend.<br/>Why we used it: It is the industry standard for Artificial Intelligence and Machine Learning, allowing seamless integration with our models.", normal_style))
    Story.append(Spacer(1, 8))
    
    Story.append(Paragraph("<b>FastAPI</b>", subheading_style))
    Story.append(Paragraph("What it is: A high-performance web framework for building APIs in Python.<br/>Why we used it: It is incredibly fast. We used it to create the endpoints (like /api/search) that the React frontend talks to.", normal_style))
    Story.append(Spacer(1, 8))
    
    Story.append(Paragraph("<b>Uvicorn</b>", subheading_style))
    Story.append(Paragraph("What it is: An ASGI web server implementation for Python.<br/>Why we used it: It actually runs our FastAPI application in the background and handles incoming web traffic.", normal_style))
    Story.append(Spacer(1, 8))
    
    Story.append(Paragraph("<b>Pandas</b>", subheading_style))
    Story.append(Paragraph("What it is: A powerful data manipulation library in Python.<br/>Why we used it: We used it to filter our satellite metadata. When a user filters by 'Date' or 'Sensor', Pandas instantly filters the massive dataset.", normal_style))
    Story.append(Spacer(1, 24))
    
    # 3. MACHINE LEARNING & AI
    Story.append(Paragraph("3. Machine Learning & AI", heading_style))
    Story.append(Spacer(1, 12))
    
    Story.append(Paragraph("<b>PyTorch</b>", subheading_style))
    Story.append(Paragraph("What it is: A premier open-source deep learning framework.<br/>Why we used it: It allows us to run our AI models entirely offline (Air-gapped) on the local CPU/GPU, fulfilling the strict military/defense requirement.", normal_style))
    Story.append(Spacer(1, 8))
    
    Story.append(Paragraph("<b>ResNet-18 (Foundation Model Proxy)</b>", subheading_style))
    Story.append(Paragraph("What it is: A Convolutional Neural Network (CNN).<br/>Why we used it: It reads satellite images and converts them into 768-Dimensional mathematical vectors (embeddings). This allows us to search by image visually rather than just by text.", normal_style))
    Story.append(Spacer(1, 8))
    
    Story.append(Paragraph("<b>DeepLabV3</b>", subheading_style))
    Story.append(Paragraph("What it is: A state-of-the-art Deep Image Segmentation model.<br/>Why we used it: We use it to compare the 'before' and 'after' satellite images pixel-by-pixel to detect exact morphological changes (like a lake expanding).", normal_style))
    Story.append(Spacer(1, 24))
    
    # 4. DATABASE & SEARCH
    Story.append(Paragraph("4. Databases & Search", heading_style))
    Story.append(Spacer(1, 12))
    
    Story.append(Paragraph("<b>FAISS (Facebook AI Similarity Search)</b>", subheading_style))
    Story.append(Paragraph("What it is: A library developed by Facebook for efficient similarity search of dense vectors.<br/>Why we used it: When you upload an image, the AI turns it into a vector. FAISS compares that vector against millions of others in milliseconds to find similar locations.", normal_style))
    Story.append(Spacer(1, 8))
    
    Story.append(Paragraph("<b>Scikit-Learn (K-Means)</b>", subheading_style))
    Story.append(Paragraph("What it is: A machine learning library.<br/>Why we used it: We used its K-Means algorithm to automatically group (cluster) similar changes together in the 'Cluster Explorer' tool.", normal_style))
    Story.append(Spacer(1, 8))
    
    Story.append(Paragraph("<b>SQLite</b>", subheading_style))
    Story.append(Paragraph("What it is: A lightweight, file-based relational database.<br/>Why we used it: We used it to store the 'Analyst Feedback' (when a user clicks Approve/Reject) directly on the local hard drive, keeping the app 100% offline.", normal_style))
    Story.append(Spacer(1, 24))
    
    # Conclusion
    Story.append(Paragraph("Key Defense Points for Judges:", heading_style))
    Story.append(Spacer(1, 12))
    
    bullets = [
        "If they ask 'Why not use standard databases like MySQL?': Explain that traditional databases can't do image similarity search. We NEEDED a Vector Database (FAISS) to search images mathematically.",
        "If they ask 'Why did you use PyTorch instead of calling ChatGPT/OpenAI?': Explain that defense/satellite platforms must be AIR-GAPPED (100% Offline). PyTorch allows the AI to run locally without internet.",
        "If they ask 'How does it run so fast?': Explain that FAISS indexes vectors in RAM, and FastAPI handles asynchronous web requests.",
        "If they ask 'How do you prevent false alarms from clouds?': Explain that we mathematically suppress confidence scores for tiles that exhibit high noise variance before sending them to the user."
    ]
    
    for bullet in bullets:
        Story.append(Paragraph(f"• {bullet}", normal_style))
        Story.append(Spacer(1, 8))
    
    doc.build(Story)

if __name__ == "__main__":
    generate_pdf()
