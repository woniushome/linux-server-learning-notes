#!/usr/bin/env bash
# disk-check.sh — warn when any filesystem is over a threshold.
# Usage: bash scripts/disk-check.sh [threshold-percent, default 80]
# Read-only: it never deletes or changes anything.
set -euo pipefail

THRESHOLD="${1:-80}"
STATUS=0

while read -r use mount; do
  pct="${use%\%}"
  if [ "$pct" -ge "$THRESHOLD" ]; then
    echo "WARN: $mount is ${use} full (threshold ${THRESHOLD}%)"
    STATUS=1
  else
    echo "OK:   $mount is ${use} full"
  fi
done < <(df -P -x tmpfs -x devtmpfs | tail -n +2 | awk '{print $5, $6}')

exit "$STATUS"
