#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
RUN_DIR="$BASE_DIR/run"
PID_FILE="$RUN_DIR/demo-service.pid"
LOG_FILE="$RUN_DIR/demo-service.log"
SERVICE_SCRIPT="$BASE_DIR/scripts/startup/demo-service.sh"

mkdir -p "$RUN_DIR"

is_demo_process() {
  local pid="$1"
  local args
  if ! args="$(ps -p "$pid" -o args= 2>/dev/null)"; then
    return 1
  fi
  [[ "$args" == *"scripts/startup/demo-service.sh"* ]]
}

if [[ -f "$PID_FILE" ]]; then
  EXISTING_PID="$(cat "$PID_FILE")"
  if is_demo_process "$EXISTING_PID"; then
    echo "demo-service is already running (pid=$EXISTING_PID)"
    exit 0
  fi
  echo "Removing stale or invalid PID file"
  rm -f "$PID_FILE"
fi

nohup "$SERVICE_SCRIPT" "$LOG_FILE" >/dev/null 2>&1 &
NEW_PID=$!
echo "$NEW_PID" > "$PID_FILE"

echo "Started demo-service (pid=$NEW_PID)"
echo "Log file: $LOG_FILE"
