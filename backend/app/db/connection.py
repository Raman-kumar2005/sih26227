import os
import sqlite3
import hashlib
from typing import Optional, Dict, Any, List
import logging

logger = logging.getLogger("sih_db")

# Read database URL from environment
DATABASE_URL = os.getenv("DATABASE_URL", "")

_is_postgis_connected = False
_pg_engine = None

def hash_password(password: str) -> str:
    return hashlib.sha256(password.encode()).hexdigest()

def init_sqlite_db():
    os.makedirs("data/db", exist_ok=True)
    conn = sqlite3.connect("data/db/feedback.db", check_same_thread=False)
    conn.execute("""
        CREATE TABLE IF NOT EXISTS feedback (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            change_id TEXT,
            action TEXT,
            comment TEXT,
            analyst_email TEXT,
            timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
        )
    """)
    conn.execute("""
        CREATE TABLE IF NOT EXISTS users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT UNIQUE,
            password_hash TEXT,
            name TEXT,
            role TEXT,
            clearance TEXT,
            agency TEXT,
            created_at DATETIME DEFAULT CURRENT_TIMESTAMP
        )
    """)
    conn.execute("""
        CREATE TABLE IF NOT EXISTS audit_logs (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_email TEXT,
            action TEXT,
            endpoint TEXT,
            ip_address TEXT,
            status_code INTEGER,
            execution_time_ms REAL,
            details TEXT,
            timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
        )
    """)
    conn.execute("""
        CREATE TABLE IF NOT EXISTS ingestion_jobs (
            job_id TEXT PRIMARY KEY,
            scene_name TEXT NOT NULL,
            aoi TEXT NOT NULL,
            status TEXT NOT NULL,
            progress INTEGER NOT NULL DEFAULT 0,
            current_stage TEXT DEFAULT 'Initialized',
            total_tiles INTEGER DEFAULT 0,
            processed_tiles INTEGER DEFAULT 0,
            changes_detected INTEGER DEFAULT 0,
            duration_sec REAL DEFAULT 0.0,
            error_message TEXT,
            result_summary TEXT DEFAULT '{}',
            created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
            updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
        )
    """)


    # Seed Default Defense Analyst Accounts
    default_users = [
        ("analyst@changetracker.gov.in", "Defense@2026", "Dilip Raman", "Senior Geospatial Analyst", "TOP SECRET // LEVEL 4", "Defense Intelligence Agency"),
        ("commander@isro.gov.in", "Isro@2026", "Col. Rajesh Verma", "Mission Commander", "LEVEL 5 ORBITAL", "ISRO Bhuvan Security Division"),
        ("admin@sih2026.gov.in", "Admin@2026", "Security Officer", "System Administrator", "SYSADMIN PROTOCOL", "Air-Gapped Ops Command")
    ]
    for email, pwd, name, role, clearance, agency in default_users:
        try:
            conn.execute("""
                INSERT OR IGNORE INTO users (email, password_hash, name, role, clearance, agency)
                VALUES (?, ?, ?, ?, ?, ?)
            """, (email.lower(), hash_password(pwd), name, role, clearance, agency))
        except Exception:
            pass
    conn.commit()
    return conn

# Try connecting to PostGIS if DATABASE_URL is configured
if DATABASE_URL.startswith("postgres"):
    try:
        from sqlalchemy import create_engine, text
        _pg_engine = create_engine(DATABASE_URL, pool_pre_ping=True, pool_size=5)
        with _pg_engine.connect() as test_conn:
            res = test_conn.execute(text("SELECT PostGIS_Version();")).fetchone()
            if res:
                _is_postgis_connected = True
                logger.info(f"PostGIS Active: {res[0]}")
    except Exception as e:
        logger.warning(f"PostGIS connection attempted but fallback to SQLite: {e}")
        _is_postgis_connected = False
        _pg_engine = None

_sqlite_conn = init_sqlite_db()

def is_postgis() -> bool:
    return _is_postgis_connected

def get_db_status() -> Dict[str, Any]:
    return {
        "engine": "PostGIS" if _is_postgis_connected else "SQLite (Air-Gap Standalone)",
        "spatial_indexing": "PostGIS GiST" if _is_postgis_connected else "In-Memory Geopandas/Shapely",
        "database_url_configured": bool(DATABASE_URL),
        "postgis_active": _is_postgis_connected,
        "mode": "Containerized Enterprise" if _is_postgis_connected else "Local Defense Air-Gapped"
    }

def get_sqlite():
    return _sqlite_conn

def get_pg_engine():
    return _pg_engine
