#!/usr/bin/env bash
# backup-home.sh — back up $HOME to a timestamped tarball.
# Usage: bash scripts/backup-home.sh [output-dir, default ./backups]
# Local only: nothing is uploaded anywhere.
set -euo pipefail

OUT_DIR="${1:-./backups}"
mkdir -p "$OUT_DIR"
STAMP="$(date +%Y%m%d-%H%M%S)"
DEST="$OUT_DIR/home-$STAMP.tar.gz"

tar -czf "$DEST" \
  --exclude=.cache \
  --exclude=Downloads \
  --exclude=backups \
  -C "$HOME" .

echo "Backup written: $DEST"
ls -lh "$DEST"
