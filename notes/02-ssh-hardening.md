# 02 — SSH hardening

## Goal

Make SSH login key-only, so a guessed password alone cannot get in.

## Commands

```bash
# On my own computer: make a key if I do not have one
ssh-keygen -t ed25519 -C "woniushome@gmail.com"

# Copy the public key to the server (asks for the password once)
ssh-copy-id deploy@SERVER_IP

# On the server, edit /etc/ssh/sshd_config:
#   PasswordAuthentication no
#   PubkeyAuthentication yes
#   PermitRootLogin no
sudo nano /etc/ssh/sshd_config
sudo sshd -t        # check the config before restarting
sudo systemctl restart ssh
```

## What I checked

- Open a **second** terminal and log in with the key before
  closing the first session. If the key login fails, the old
  session is still there to fix `sshd_config`.
- `sudo grep PasswordAuthentication /etc/ssh/sshd_config`
  shows `no`.
- Failed logins are visible with `sudo journalctl -u ssh --since today`.

## Mistakes

- Restarting SSH before testing the key in a second window.
  The safe order is: add key → test key in a new window →
  disable passwords → restart. Never the reverse.
- Editing the wrong file (`ssh_config` is the client,
  `sshd_config` is the server).

## Optional next step

Install fail2ban to slow down brute-force attempts:

```bash
sudo apt install -y fail2ban
sudo systemctl enable --now fail2ban
sudo fail2ban-client status sshd
```
