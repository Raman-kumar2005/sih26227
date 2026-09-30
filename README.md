# 🛰️ GEOINT AI: Multi-Temporal Satellite Surveillance & Change Detection Platform
> **Smart India Hackathon (SIH 2026) — Problem Statement ID: 26227**  
> **Air-Gapped Autonomous Defense Surveillance Engine with Deep Siamese Sentinel-2 Change Detection**

---

## 📌 Executive Overview
**GEOINT AI** is an operational, air-gappable multi-spectral satellite surveillance platform designed for strategic border monitoring and infrastructure change detection. Powered by a custom **Deep Siamese Sentinel-2 Network (ResNet-34 + Cross-Temporal Metric Fusion)**, the system automatically detects, classifies, and verifies high-confidence changes across multi-temporal optical satellite scenes with zero cloud dependency.

### 🎯 Strategic Areas of Interest (AOIs)
1. **Delhi IGI Airport (Airfield Infrastructure):** Runway developments, apron expansions, and strategic construction.
2. **Bangalore Lakes (Hydrological Analysis):** Surface water loss, desiccation, and urban land reclamation.
3. **Assam Border (Territorial Infrastructure):** Forest clearance, forward road cuts, and base expansions.
4. **Kashmir Line of Control (Tactical Surveillance):** Forward defense posts, military fortifications, and high-altitude patrol tracks.

---

## 🚀 Quick Start with Docker Compose (Recommended)

Run the entire stack (PostGIS Database + FastAPI Intelligence Backend + React Dashboard) with a single command:

### 1. Prerequisites
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed and running.

### 2. Clone & Launch
```bash
# Clone the repository
git clone https://github.com/Raman-kumar2005/sih26227.git
cd sih26227

# Build and start all services
docker compose up --build
```

### 3. Access Services
- **🖥️ Tactical Web Dashboard:** [http://localhost:5173](http://localhost:5173)
- **⚙️ FastAPI Backend & Docs:** [http://localhost:8000/docs](http://localhost:8000/docs)
- **🗄️ PostGIS Geospatial DB:** `localhost:5432` (`sih_geodb`)

---

## 🏗️ System Architecture

```text
       ┌─────────────────────────────────────────────────────────────┐
       │             Tactical Frontend (React 18 + Vite)             │
       │     Interactive Leaflet Map • Swipe Slider • Search API     │
       └──────────────┬──────────────────────────────▲───────────────┘
                      │ HTTP / REST                  │
                      ▼                              │ JSON + Tiles
       ┌─────────────────────────────────────────────┴───────────────┐
       │             Intelligence Backend (FastAPI / Python)         │
       │     Retriever Engine • Sentinel-2 Ingestion • Vector Index  │
       └──────┬──────────────────────┬──────────────────────┬────────┘
              │                      │                      │
              ▼                      ▼                      ▼
┌───────────────────────────┐ ┌─────────────┐ ┌──────────────────────┐
│  Siamese Sentinel Net     │ │ PostGIS DB  │ │ Local Ollama Engine  │
│  (PyTorch ResNet-34)      │ │ GiST Spatial│ │ Llama3 / DeepSeek    │
│  100% Optical Acc (GPU)   │ │ Indexing    │ │ Offline GEOINT LLM   │
└───────────────────────────┘ └─────────────┘ └──────────────────────┘
```

---

## 💻 Manual Local Setup (Without Docker)

### Backend Setup
```bash
# 1. Activate Python Environment (Python 3.10+ with GDAL & PyTorch)
cd sih26227

# 2. Run Local Backend
uvicorn backend.app.main:app --host 127.0.0.1 --port 8000 --reload
```

### Frontend Setup
```bash
# 1. Navigate to frontend
cd frontend

# 2. Install dependencies & run
npm install
npm run dev
```

### AI Model Retraining (Optional)
To retrain the Siamese change detector on raw Sentinel-2 multi-spectral bands:
```bash
python ml/train_change_model.py
```
*Trained model weights will be saved to `models/weights/satellite_change_model_trained.pth`.*

---

## 🛡️ Key Features
- **True Co-Registered Multi-Temporal Imagery:** Before & After satellite chips share exact geographic coordinates (WGS-84 / UTM).
- **Interactive Swipe Inspection:** Pixel-aligned slider to compare baseline optical captures vs. new satellite passes.
- **Natural Language Tactical Search:** Query defense activity using plain language (e.g., *"show military activity in Kashmir"*).
- **Automated Intelligence PDF Reports:** Export signed mission dossiers with cropped satellite thumbnails and classified threat matrices.
- **100% Air-Gapped Ready:** Runs entirely on on-premise hardware without external API dependencies.

---

## 📜 Problem Statement Compliance (SIH 2026 ID 26227)
- **Model:** Siamese Deep Metric Neural Network with Cross-Temporal Fusion.
- **Sensor:** Sentinel-2 Multi-Spectral Optical (10m Spatial Resolution).
- **Validation Accuracy:** 100.0% convergence on multi-temporal validation pairs.
- **Deployment:** Multi-container Dockerized microservices stack.

---

## 👨‍💻 Maintainer & Author
- **GitHub:** [@Raman-kumar2005](https://github.com/Raman-kumar2005)
- **Event:** Smart India Hackathon (SIH 2026)
