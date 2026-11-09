# Linux Server Learning Notes

A personal, hands-on learning project for Linux server administration on
Ubuntu / Debian. Notes are written while practising on a small VPS:
what I tried, what worked, and the exact commands I used.

> Learning only. No production secrets, no credentials, no proxy
> configuration in this repository.

## Contents

- `notes/01-ubuntu-basics.md` — first login, updates, users, sudo
- `notes/02-ssh-hardening.md` — key login, disabling password auth, fail2ban basics
- `notes/03-systemd-services.md` — running a service with systemd, logs with journalctl
- `notes/04-backup.md` — a simple, restorable backup routine with rsync / tar
- `notes/05-monitoring.md` — disk, memory, CPU and service health checks
- `scripts/sysinfo.sh` — print OS, CPU, memory, disk and uptime (read-only)
- `scripts/disk-check.sh` — warn when a filesystem is over a threshold (read-only)
- `scripts/backup-home.sh` — back up `$HOME` to a timestamped tarball (local only)

## Quick start

```bash
# Read-only checks — safe to run anywhere
bash scripts/sysinfo.sh
bash scripts/disk-check.sh
bash scripts/disk-check.sh 80

# Backup (writes one tarball under ./backups by default)
bash scripts/backup-home.sh
```

## How the notes are organised

Each note follows the same shape:

1. Goal — what I wanted to learn
2. Commands — what I actually ran
3. What I checked — how I verified it worked
4. Mistakes — what went wrong and what I changed

## Environment used

- Ubuntu 22.04 / 24.04 and Debian 12 (whatever the VPS image was)
- A non-root user with sudo
- SSH key authentication only

## License

MIT — see `LICENSE`.
