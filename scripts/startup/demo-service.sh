#!/usr/bin/env bash
set -euo pipefail

LOG_FILE="${1:-/root/srv/remote/run/demo-service.log}"

mkdir -p "$(dirname "$LOG_FILE")"

cleanup() {
  echo "$(date -Is) | demo-service stopping" >> "$LOG_FILE"
  exit 0
}

trap cleanup SIGINT SIGTERM

echo "$(date -Is) | demo-service started (pid=$$)" >> "$LOG_FILE"

while true; do
  echo "$(date -Is) | heartbeat from demo-service" >> "$LOG_FILE"
  # Sleep in short intervals so SIGTERM is handled quickly.
  for _ in {1..15}; do
    sleep 1
  done
done
