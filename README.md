# Remote Startup Scripts Lab

This folder is a small practice lab for learning Linux navigation and service management on a remote server.

## What you get

- `scripts/startup/demo-service.sh` - a tiny long-running service that writes timestamps to a log
- `scripts/startup/start-demo.sh` - starts the demo service in the background
- `scripts/startup/stop-demo.sh` - stops the background demo service
- `scripts/startup/status-demo.sh` - shows service status and recent logs
- `scripts/startup/install-systemd.sh` - optional: installs a real `systemd` service

## First-time setup

```bash
cd /root/srv/remote
ls -la
chmod +x scripts/startup/*.sh
```

## Run the local demo service (no systemd yet)

```bash
./scripts/startup/start-demo.sh
./scripts/startup/status-demo.sh
```

Wait 20-30 seconds, then check status again:

```bash
./scripts/startup/status-demo.sh
```

Stop it:

```bash
./scripts/startup/stop-demo.sh
./scripts/startup/status-demo.sh
```

## Optional: install as a real systemd service

This step is closer to real production service management.

```bash
sudo ./scripts/startup/install-systemd.sh
systemctl status remote-demo --no-pager
```

Useful commands:

```bash
sudo systemctl restart remote-demo
sudo systemctl stop remote-demo
sudo systemctl start remote-demo
journalctl -u remote-demo -n 30 --no-pager
```

## Navigation practice checklist

Try these while learning:

```bash
pwd
cd /root/srv/remote
ls
ls -la scripts/startup
cd scripts/startup
./status-demo.sh
cd ../..
```

## Notes

- Runtime files are written to `run/` (`demo-service.pid`, `demo-service.log`)
- These scripts are intentionally simple and safe for learning
