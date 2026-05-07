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

- `cd /root/srv/remote` - move into this project folder.
- `ls -la` - list all files (including hidden ones like `.git`) so you can inspect the directory.
- `chmod +x scripts/startup/*.sh` - make all startup scripts executable so you can run them directly.

## Run the local demo service (no systemd yet)

```bash
./scripts/startup/start-demo.sh
./scripts/startup/status-demo.sh
```

- `./scripts/startup/start-demo.sh` - launches the demo service in the background and writes its PID to `run/demo-service.pid`.
- `./scripts/startup/status-demo.sh` - checks whether the service is running and shows the latest log lines.

Wait 20-30 seconds, then check status again:

```bash
./scripts/startup/status-demo.sh
```

- Running status again lets you confirm the service is still alive and producing heartbeat logs over time.

Stop it:

```bash
./scripts/startup/stop-demo.sh
./scripts/startup/status-demo.sh
```

- `./scripts/startup/stop-demo.sh` - sends a stop signal to the running demo process and cleans up the PID file.
- `./scripts/startup/status-demo.sh` - confirms the service is stopped.

## Optional: install as a real systemd service

This step is closer to real production service management.

```bash
sudo ./scripts/startup/install-systemd.sh
systemctl status remote-demo --no-pager
```

- `sudo ./scripts/startup/install-systemd.sh` - installs and starts a `systemd` service unit named `remote-demo`.
- `systemctl status remote-demo --no-pager` - shows service health, process info, and recent logs without opening a pager.

Useful commands:

```bash
sudo systemctl restart remote-demo
sudo systemctl stop remote-demo
sudo systemctl start remote-demo
journalctl -u remote-demo -n 30 --no-pager
```

- `sudo systemctl restart remote-demo` - reload the service process (use after script updates).
- `sudo systemctl stop remote-demo` - stop the service.
- `sudo systemctl start remote-demo` - start the service.
- `journalctl -u remote-demo -n 30 --no-pager` - show the most recent 30 log lines for this service.

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

- `pwd` - print your current location in the filesystem.
- `cd /root/srv/remote` - jump to the project root.
- `ls` - list visible files in the current directory.
- `ls -la scripts/startup` - inspect script files with permissions and ownership details.
- `cd scripts/startup` - move into the scripts folder.
- `./status-demo.sh` - run a script from the current folder.
- `cd ../..` - move back up two directory levels.

## Notes

- Runtime files are written to `run/` (`demo-service.pid`, `demo-service.log`)
- These scripts are intentionally simple and safe for learning
