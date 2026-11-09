# 05 — Monitoring: disk, memory, CPU, services

## Goal

Answer "is the server healthy?" in under a minute, with commands
I can remember, before reaching for a dashboard.

## Commands

```bash
# Disk — the one that fills up silently
df -h
bash scripts/disk-check.sh 80

# Memory and load
free -h
uptime

# What is using CPU / memory right now?
top -b -n 1 | head -20
ps aux --sort=-%mem | head

# Is a service actually running?
systemctl is-active ssh
systemctl status ssh --no-pager

# Everything in one shot (read-only)
bash scripts/sysinfo.sh
```

## What I checked

- `df -h` — no filesystem over 80% on a healthy day.
- `free -h` — some swap use is normal; constant heavy swap is not.
- `systemctl is-active ssh` prints `active`.

## Mistakes

- Watching CPU only. On a small VPS the first thing that bites
  is usually disk (logs, backups) or memory, not CPU.
- Checking once and forgetting. A five-minute daily check
  (`sysinfo.sh` + `disk-check.sh`) catches most slow failures
  before they become outages.
