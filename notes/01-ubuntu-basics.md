# 01 — Ubuntu / Debian basics

## Goal

Log in to a fresh VPS, bring it up to date, and set up a normal
non-root user before doing anything else.

## Commands

```bash
# Who and where am I?
whoami; hostname; lsb_release -a; uname -a

# Update the package index and installed packages
sudo apt update
sudo apt upgrade -y

# A non-root user with sudo (do this first, then use it)
sudo adduser deploy
sudo usermod -aG sudo deploy

# See what is listening (no need to memorise every line)
ss -tlnp
```

## What I checked

- `lsb_release -a` shows the expected Ubuntu / Debian version.
- `sudo -l -U deploy` shows the new user can use sudo.
- `ss -tlnp` shows only the services I expect (usually just SSH, port 22).

## Mistakes

- Running everything as root at first. It works, until one typo
  deletes the wrong thing. Now I use a normal user + sudo for
  everything, and root only to fix a broken sudo setup.
- Forgetting `apt update` before `apt install`, then wondering why
  a package version looked old.
