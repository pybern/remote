#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
PID_FILE="$BASE_DIR/run/demo-service.pid"
LOG_FILE="$BASE_DIR/run/demo-service.log"

is_demo_process() {
  local pid="$1"
  local args
  if ! args="$(ps -p "$pid" -o args= 2>/dev/null)"; then
    return 1
  fi
  [[ "$args" == *"scripts/startup/demo-service.sh"* ]]
}

if [[ -f "$PID_FILE" ]]; then
  PID="$(cat "$PID_FILE")"
  if is_demo_process "$PID"; then
    echo "demo-service status: RUNNING (pid=$PID)"
  else
    echo "demo-service status: STOPPED (stale pid file: $PID)"
  fi
else
  echo "demo-service status: STOPPED"
fi

if [[ -f "$LOG_FILE" ]]; then
  echo
  echo "Last 5 log lines from $LOG_FILE:"
  tail -n 5 "$LOG_FILE"
else
  echo
  echo "No log file yet: $LOG_FILE"
fi
