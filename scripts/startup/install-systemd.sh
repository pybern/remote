#!/usr/bin/env bash
set -euo pipefail

if [[ "${EUID}" -ne 0 ]]; then
  echo "Please run as root (example: sudo ./scripts/startup/install-systemd.sh)"
  exit 1
fi

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
SERVICE_SCRIPT="$BASE_DIR/scripts/startup/demo-service.sh"
RUN_DIR="$BASE_DIR/run"
LOG_FILE="$RUN_DIR/demo-service.log"
UNIT_FILE="/etc/systemd/system/remote-demo.service"

mkdir -p "$RUN_DIR"

cat > "$UNIT_FILE" <<EOF
[Unit]
Description=Remote Demo Service (Learning)
After=network.target

[Service]
Type=simple
ExecStart=$SERVICE_SCRIPT $LOG_FILE
Restart=always
RestartSec=5
User=root
WorkingDirectory=$BASE_DIR

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable --now remote-demo.service

echo "Installed and started remote-demo.service"
echo "Check status with: systemctl status remote-demo --no-pager"
