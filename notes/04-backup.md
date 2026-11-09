# 04 — A simple, restorable backup

## Goal

Have one backup routine I actually run, and prove I can restore
from it — a backup I never tested is not a backup.

## Routine

```bash
# The script in this repo (local only, no upload)
bash scripts/backup-home.sh

# It creates ./backups/home-YYYYMMDD-HHMMSS.tar.gz
ls -lh backups/

# List what is inside, without extracting
tar -tzf backups/home-YYYYMMDD-HHMMSS.tar.gz | head

# Restore test: extract to a scratch directory, never over $HOME
mkdir -p /tmp/restore-test
tar -xzf backups/home-YYYYMMDD-HHMMSS.tar.gz -C /tmp/restore-test
ls /tmp/restore-test
```

## Rules I follow

1. Back up before any risky change (upgrade, new service, config edit).
2. Keep at least the last three tarballs; delete older ones by hand
   until I automate the rotation.
3. Never store a backup in the same place as the only copy of
   the data. A copy on the same disk protects against my own
   mistakes, not against disk failure.

## Mistakes

- Early backups included huge caches and downloads. Now I
  exclude obvious junk (`--exclude=.cache`, `Downloads/`,
  `backups/` itself) — see `scripts/backup-home.sh`.
