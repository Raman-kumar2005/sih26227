@echo off
REM ====================================================================
REM SIH 2026 Problem ID: 26227
REM Air-Gapped / Military Server Deployment Bundler
REM Creates offline container tarball for pen-drive transfer
REM ====================================================================

echo [1/3] Building Production Docker Images...
docker compose build

echo [2/3] Exporting Images into Single Offline Tarball...
docker save postgis/postgis:16-3.4-alpine sih26227-backend:latest sih26227-frontend:latest -o sih26227_offline_bundle.tar

echo [3/3] Generating SHA256 Checksum for Security Audit...
certutil -hashfile sih26227_offline_bundle.tar SHA256 > sih26227_offline_bundle.tar.sha256

echo ====================================================================
echo SUCCESS: Offline bundle created: sih26227_offline_bundle.tar
echo Ready for transfer to air-gapped target machines via secure media.
echo ====================================================================
