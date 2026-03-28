#!/usr/bin/env bash
#
#  Start 64 TC-32 emulator instances on ports 9400-9463.
#  Requires GNU parallel or will fall back to background processes.
#
#  Usage:
#    ./run_simulators.bash          start all 64
#    ./run_simulators.bash --stop   kill all instances
#

BASE_PORT=9400
NUM_DEVICES=64

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
EMULATOR="$SCRIPT_DIR/tc32_emulator.bash"

function start_all
{
    if command -v parallel >/dev/null 2>&1; then
        printf "Starting %d emulators with GNU parallel\n" "$NUM_DEVICES"
        seq "$BASE_PORT" $((BASE_PORT + NUM_DEVICES - 1)) \
            | parallel --jobs "$NUM_DEVICES" "$EMULATOR" --port {}
    else
        printf "GNU parallel not found — starting emulators in background\n"
        for port in $(seq "$BASE_PORT" $((BASE_PORT + NUM_DEVICES - 1))); do
            "$EMULATOR" --port "$port" &
            printf "Started emulator on port %d (PID %d)\n" "$port" "$!"
        done
        printf "All %d emulators started.\n" "$NUM_DEVICES"
        wait
    fi
}

function stop_all
{
    printf "Stopping all tc32_emulator instances...\n"
    pkill -f "tc32_emulator.bash" && printf "Done.\n" || printf "No instances found.\n"
}

case "${1:-}" in
    --stop) stop_all ;;
    *)      start_all ;;
esac
