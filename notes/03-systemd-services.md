# 03 — Running a service with systemd

## Goal

Understand how a long-running program is started, restarted and
inspected on a modern Linux server, using a harmless example
(a tiny Python HTTP server is enough to learn the mechanics).

## Example unit: /etc/systemd/system/hello.service

```ini
[Unit]
Description=Hello learning service
After=network.target

[Service]
Type=simple
User=deploy
WorkingDirectory=/home/deploy
ExecStart=/usr/bin/python3 -m http.server 18080 --bind 127.0.0.1
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
```

## Commands

```bash
sudo systemctl daemon-reload
sudo systemctl enable --now hello
sudo systemctl status hello --no-pager
sudo journalctl -u hello -f        # Ctrl-C to stop following
sudo systemctl restart hello
sudo systemctl stop hello
curl -s http://127.0.0.1:18080/ | head
```

## What I checked

- `systemctl status hello` shows `active (running)`.
- `journalctl -u hello` shows the start lines, not errors.
- After `systemctl stop hello`, `curl` fails — the service
  really was the thing answering.

## Mistakes

- Forgetting `daemon-reload` after editing a unit file, then
  wondering why nothing changed.
- Binding a learning service to `0.0.0.0` by default. Bind to
  `127.0.0.1` unless the service genuinely needs to be public.
