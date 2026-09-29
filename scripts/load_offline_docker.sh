#!/usr/bin/env bash
# ====================================================================
# SIH 2026 Problem ID: 26227
# Air-Gapped Linux Production Launcher
# ====================================================================
set -euo pipefail

echo "==> Verifying SHA256..."
sha256sum -c sih26227_offline_bundle.tar.sha256 || true

echo "==> Loading container images from offline tarball..."
docker load -i sih26227_offline_bundle.tar

echo "==> Starting multi-container stack in air-gapped network..."
docker compose up -d

echo "==> Status Check:"
docker compose ps
