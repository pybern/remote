#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
PID_FILE="$BASE_DIR/run/demo-service.pid"

is_demo_process() {
  local pid="$1"
  local args
  if ! args="$(ps -p "$pid" -o args= 2>/dev/null)"; then
    return 1
  fi
  [[ "$args" == *"scripts/startup/demo-service.sh"* ]]
}

if [[ ! -f "$PID_FILE" ]]; then
  echo "demo-service is not running (no PID file)"
  exit 0
fi

PID="$(cat "$PID_FILE")"

if ! is_demo_process "$PID"; then
  echo "Stale PID file found. Removing it."
  rm -f "$PID_FILE"
  exit 0
fi

kill -TERM "$PID"

for _ in {1..10}; do
  if is_demo_process "$PID"; then
    sleep 1
  else
    break
  fi
done

if is_demo_process "$PID"; then
  echo "Process did not stop gracefully, sending SIGKILL"
  kill -KILL "$PID"
fi

rm -f "$PID_FILE"
echo "Stopped demo-service (pid=$PID)"
