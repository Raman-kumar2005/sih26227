# SIH 2026 Problem ID: 26227 - Production Architecture
## Pillar 1: Air-Gapped Multi-Container Orchestration & PostGIS Spatial Database

---

### 1. Executive Architecture Overview

To transition from the MVP prototype that won the Internal Round to an enterprise, production-grade defense platform, we implemented **Option 1: Containerization and PostGIS Database Integration**.

The architecture adheres strictly to **Ministry of Defence (MoD) and ISRO Air-Gapped Security Guidelines**:
- **Zero Cloud Egress**: Zero telemetry or external network calls.
- **Dual-Mode Adapter Pattern**: Seamlessly runs either inside containerized environments (PostGIS GiST spatial engine) or in standalone defense laptops (SQLite + Shapely fallback) with identical APIs.
- **Physical Media Deployment**: Bundles the entire multi-container stack into a single `.tar` archive for offline installation via USB onto air-gapped military servers.

---

### 2. Multi-Container Topography

```
                       [ Host Browser / Client ]
                                   │
                                   ▼ :80 / :5173
                   ┌───────────────────────────────┐
                   │   Nginx Reverse Proxy & SPA   │
                   │   (Alpine Linux / Gzip / CSP) │
                   └───────────────┬───────────────┘
                                   │
               ┌───────────────────┴───────────────────┐
               ▼ :8000                                 ▼ /data/
 ┌───────────────────────────────┐     ┌───────────────────────────────┐
 │   FastAPI Intelligence Engine │     │   Local Offline Map Tiles     │
 │   (PyTorch + Clay + GDAL)     │     │   (GeoTIFF / WebP / JPG)      │
 └───────────────┬───────────────┘     └───────────────────────────────┘
                 │
                 ▼ :5432 (Internal Bridge)
 ┌─────────────────────────────────────────────────────────────┐
 │           PostgreSQL 16 + PostGIS 3.4 Database              │
 │   - Spatial GiST Indexing: ST_Intersects, ST_DWithin        │
 │   - Tables: changes, satellite_scenes, users, audit_logs    │
 │   - 150 Seed Changes & Defense RBAC Accounts                │
 └─────────────────────────────────────────────────────────────┘
```

---

### 3. File Deliverables & Component Mapping

| Component | Path | Description |
|---|---|---|
| **PostGIS Init Schema** | [`docker/01_init_postgis.sql`](file:///D:/Sih%202026/sih26227/docker/01_init_postgis.sql) | DDL for tables (`changes`, `satellite_scenes`, `users`, `audit_logs`), GiST spatial indexes, and roles. |
| **PostGIS Seed Data** | [`docker/02_seed_data.sql`](file:///D:/Sih%202026/sih26227/docker/02_seed_data.sql) | 150 multi-temporal scored changes with Polygons in EPSG:4326. |
| **Migration Pipeline** | [`scripts/migrate_to_postgis.py`](file:///D:/Sih%202026/sih26227/scripts/migrate_to_postgis.py) | Automated Parquet/GeoJSON converter to live PostGIS or SQL dumps. |
| **Backend Dockerfile** | [`Dockerfile.backend`](file:///D:/Sih%202026/sih26227/Dockerfile.backend) | Multi-stage build with GDAL/GEOS C++ libs, PyTorch CPU, non-root user `sih_analyst`. |
| **Frontend Dockerfile** | [`Dockerfile.frontend`](file:///D:/Sih%202026/sih26227/Dockerfile.frontend) | Node 20 build + Nginx Alpine runner with gzip and security headers. |
| **Reverse Proxy Config** | [`docker/nginx.conf`](file:///D:/Sih%202026/sih26227/docker/nginx.conf) | Production reverse proxy routing `/api/` to FastAPI and `/` to React. |
| **Compose Specification**| [`docker-compose.yml`](file:///D:/Sih%202026/sih26227/docker-compose.yml) | Multi-service orchestration with persistent volume and healthchecks. |
| **Database Connection** | [`backend/app/db/connection.py`](file:///D:/Sih%202026/sih26227/backend/app/db/connection.py) | Dynamic adapter supporting PostgreSQL/PostGIS with fallback to SQLite. |
| **Spatial Engine** | [`backend/app/db/spatial.py`](file:///D:/Sih%202026/sih26227/backend/app/db/spatial.py) | GiST-indexed bounding box search, point-radius queries, area calculations. |
| **Offline Bundler** | [`scripts/bundle_offline_docker.bat`](file:///D:/Sih%202026/sih26227/scripts/bundle_offline_docker.bat) | Packages containers into `sih26227_offline_bundle.tar` with SHA-256 hash. |
| **Offline Loader** | [`scripts/load_offline_docker.bat`](file:///D:/Sih%202026/sih26227/scripts/load_offline_docker.bat) | Loads tarball and starts stack on air-gapped machines. |

---

### 4. Verification & Health Monitoring

The system now exposes production telemetry endpoints:
- `GET /api/health`: Returns API, FAISS index, and DB status.
- `GET /api/system/status`: Returns air-gapped deployment metrics, vector index count, and database backend details.
- `GET /api/spatial/search`: Spatial filtering by bounding box, AOI, and confidence score.
- `GET /api/spatial/stats`: Returns change metrics, aggregate area ($m^2$), and temporal range.
