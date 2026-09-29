@echo off
REM ====================================================================
REM SIH 2026 Problem ID: 26227
REM Air-Gapped / Military Server Loader & Runner
REM Runs 100%% offline with ZERO internet access
REM ====================================================================

echo [1/3] Verifying Integrity Checksum...
certutil -hashfile sih26227_offline_bundle.tar SHA256

echo [2/3] Loading Offline Docker Images from Tarball...
docker load -i sih26227_offline_bundle.tar

echo [3/3] Launching Production Multi-Container Stack...
docker compose up -d

echo ====================================================================
echo SYSTEM OPERATIONAL (OFFLINE AIR-GAPPED):
echo - Frontend UI: http://localhost
echo - Backend API: http://localhost:8000
echo - PostGIS DB:  localhost:5432 (Database: sih_geodb)
echo ====================================================================
