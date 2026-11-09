#!/usr/bin/env bash
# sysinfo.sh — print a short, read-only system summary.
# Usage: bash scripts/sysinfo.sh
set -euo pipefail

echo "== OS =="
if command -v lsb_release >/dev/null 2>&1; then
  lsb_release -d -r
else
  cat /etc/os-release | head -3
fi
uname -r

echo
echo "== Uptime / load =="
uptime

echo
echo "== Memory =="
free -h

echo
echo "== Disk =="
df -h -x tmpfs -x devtmpfs

echo
echo "== Top memory processes =="
ps aux --sort=-%mem | head -6
