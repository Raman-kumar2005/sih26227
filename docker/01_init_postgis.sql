-- ====================================================================
-- SIH 2026 Problem ID: 26227
-- AI-Powered Multi-Temporal Satellite Change Detection Platform
-- Production PostGIS Initialization & Air-Gapped Schema Script
-- ====================================================================

-- 1. Enable Spatial Extensions
CREATE EXTENSION IF NOT EXISTS postgis;
CREATE EXTENSION IF NOT EXISTS postgis_raster;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 2. Clean Existing Tables (for idempotent container initialization)
DROP TABLE IF EXISTS audit_logs CASCADE;
DROP TABLE IF EXISTS feedback CASCADE;
DROP TABLE IF EXISTS changes CASCADE;
DROP TABLE IF EXISTS satellite_scenes CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- 3. Users & Role-Based Access Control (RBAC) Table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    role VARCHAR(100) NOT NULL DEFAULT 'Defense Analyst',
    clearance VARCHAR(100) NOT NULL DEFAULT 'CONFIDENTIAL // LEVEL 2',
    agency VARCHAR(255) NOT NULL DEFAULT 'Geospatial Surveillance Center',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Seed Default Production Accounts
INSERT INTO users (email, password_hash, name, role, clearance, agency) VALUES
('analyst@changetracker.gov.in', 'cb7f23a9d7d4c0c1b72e5ad812f8e12d4d9b626d7c71e981ad6631ad0cf7b029', 'Dilip Raman', 'Senior Geospatial Analyst', 'TOP SECRET // LEVEL 4', 'Defense Intelligence Agency'),
('commander@isro.gov.in', 'c3f68d90faec2e4aa83f6f8976b6d51dfd7b420061e8fa87e148e4b788ceb626', 'Col. Rajesh Verma', 'Mission Commander', 'LEVEL 5 ORBITAL', 'ISRO Bhuvan Security Division'),
('admin@sih2026.gov.in', '94132479e0bf8ca9b20ea66085a687352fc4d262ff44dd92d3f7e6f8ad621379', 'Security Officer', 'System Administrator', 'SYSADMIN PROTOCOL', 'Air-Gapped Ops Command')
ON CONFLICT (email) DO NOTHING;

-- 4. Multi-Temporal Detected Changes Table (Enterprise PostGIS)
CREATE TABLE changes (
    id SERIAL PRIMARY KEY,
    change_id VARCHAR(255) UNIQUE NOT NULL,
    tile_id VARCHAR(255) NOT NULL,
    aoi VARCHAR(100) NOT NULL,
    detected_date TIMESTAMP WITH TIME ZONE NOT NULL,
    baseline_ref VARCHAR(100) DEFAULT 'monsoon_N=8',
    sensor VARCHAR(100) NOT NULL DEFAULT 'sentinel-2',
    embed_distance DOUBLE PRECISION DEFAULT 0.0,
    embed_zscore DOUBLE PRECISION DEFAULT 0.0,
    dndvi DOUBLE PRECISION DEFAULT 0.0,
    dndbi DOUBLE PRECISION DEFAULT 0.0,
    dndwi DOUBLE PRECISION DEFAULT 0.0,
    usable_fraction DOUBLE PRECISION DEFAULT 1.0,
    coreg_residual DOUBLE PRECISION DEFAULT 0.0,
    confidence DOUBLE PRECISION NOT NULL DEFAULT 0.5,
    confidence_breakdown JSONB DEFAULT '{}'::jsonb,
    geom GEOMETRY(Polygon, 4326) NOT NULL,
    area_sqm DOUBLE PRECISION GENERATED ALWAYS AS (ST_Area(ST_Transform(geom, 3857))) STORED,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- High-Performance PostGIS Spatial & Attribute Indexes
CREATE INDEX idx_changes_geom ON changes USING GIST (geom);
CREATE INDEX idx_changes_aoi ON changes (aoi);
CREATE INDEX idx_changes_date ON changes (detected_date);
CREATE INDEX idx_changes_confidence ON changes (confidence);
CREATE INDEX idx_changes_zscore ON changes (embed_zscore);

-- 5. Satellite Scenes Footprint Table
CREATE TABLE satellite_scenes (
    id SERIAL PRIMARY KEY,
    scene_id VARCHAR(255) UNIQUE NOT NULL,
    aoi VARCHAR(100) NOT NULL,
    sensor VARCHAR(100) NOT NULL,
    acquisition_date TIMESTAMP WITH TIME ZONE NOT NULL,
    cloud_cover_pct DOUBLE PRECISION DEFAULT 0.0,
    footprint GEOMETRY(Polygon, 4326) NOT NULL,
    tile_grid_count INTEGER DEFAULT 0,
    file_path TEXT,
    metadata JSONB DEFAULT '{}'::jsonb,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_scenes_footprint ON satellite_scenes USING GIST (footprint);
CREATE INDEX idx_scenes_date ON satellite_scenes (acquisition_date);
CREATE INDEX idx_scenes_aoi ON satellite_scenes (aoi);

-- 6. Analyst Feedback / Verification Table
CREATE TABLE feedback (
    id SERIAL PRIMARY KEY,
    change_id VARCHAR(255) NOT NULL,
    action VARCHAR(50) NOT NULL, -- 'verified', 'dismissed', 'escalated'
    comment TEXT,
    analyst_email VARCHAR(255),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_feedback_change ON feedback (change_id);

-- 7. Defense Air-Gap Security Audit Log Table
CREATE TABLE audit_logs (
    id SERIAL PRIMARY KEY,
    user_email VARCHAR(255),
    action VARCHAR(100) NOT NULL,
    endpoint VARCHAR(255) NOT NULL,
    ip_address VARCHAR(45),
    status_code INTEGER,
    execution_time_ms DOUBLE PRECISION,
    details JSONB DEFAULT '{}'::jsonb,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_audit_timestamp ON audit_logs (created_at);
CREATE INDEX idx_audit_user ON audit_logs (user_email);

-- 8. Spatial Helper View for Fast Analytics
CREATE OR REPLACE VIEW v_active_high_priority_changes AS
SELECT 
    c.id,
    c.change_id,
    c.aoi,
    c.detected_date,
    c.sensor,
    c.confidence,
    c.embed_zscore,
    c.area_sqm,
    ST_AsGeoJSON(c.geom)::jsonb AS geojson,
    c.confidence_breakdown
FROM changes c
WHERE c.confidence >= 0.6
ORDER BY c.confidence DESC, c.detected_date DESC;

-- 9. Asynchronous Ingestion & Tiling Jobs Table
CREATE TABLE IF NOT EXISTS ingestion_jobs (
    job_id VARCHAR(64) PRIMARY KEY,
    scene_name VARCHAR(255) NOT NULL,
    aoi VARCHAR(100) NOT NULL,
    status VARCHAR(50) NOT NULL,
    progress INTEGER NOT NULL DEFAULT 0,
    current_stage VARCHAR(100) DEFAULT 'Initialized',
    total_tiles INTEGER DEFAULT 0,
    processed_tiles INTEGER DEFAULT 0,
    changes_detected INTEGER DEFAULT 0,
    duration_sec DOUBLE PRECISION DEFAULT 0.0,
    error_message TEXT,
    result_summary JSONB DEFAULT '{}'::jsonb,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_jobs_status ON ingestion_jobs (status);
CREATE INDEX idx_jobs_created ON ingestion_jobs (created_at DESC);

