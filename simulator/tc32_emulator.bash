#!/usr/bin/env bash
#
#  The program is free software: you can redistribute
#  it and/or modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation, either version 2 of the
#  License, or any newer version.
#
#  This program is distributed in the hope that it will be useful, but WITHOUT
#  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
#  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
#  more details.
#
#  You should have received a copy of the GNU General Public License along with
#  this program. If not, see https://www.gnu.org/licenses/gpl-2.0.txt
#
#  Usage: ./tc32_emulator.bash                (uses default port)
#         ./tc32_emulator.bash --port 9400    (uses 9400 port)
#
# - author : Jeong Han Lee, Dr.rer.nat.
# - email  : jeonglee@lbl.gov
#

set -e

declare -a temps

# Check required commands are available
for cmd in socat mktemp; do
    command -v "$cmd" >/dev/null 2>&1 || { printf "%s is required\n" "$cmd"; exit 1; }
done

DEFAULT_PORT="9400"
PORT=""

while [[ $# -gt 0 ]]; do
    case $1 in
        --port)
            if [[ -z "$2" || "$2" =~ ^-- ]]; then
                printf "Error: --port requires a value.\nUsage: %s [--port PORT]\n" "$0"
                exit 1
            fi
            PORT="$2"
            shift 2
            ;;
        *)
            printf "Unknown option: %s\nUsage: %s [--port PORT]\n" "$1" "$0"
            exit 1
            ;;
    esac
done

PORT="${PORT:-$DEFAULT_PORT}"

SOCAT_LOG=$(mktemp)

socat -d -d PTY,raw,echo=0 TCP-LISTEN:"$PORT",reuseaddr,fork 2>&1 | tee "$SOCAT_LOG" &
SOCAT_PID=$!

function cleanup
{
    kill "$SOCAT_PID" 2>/dev/null
    rm -f "$SOCAT_LOG"
}
trap cleanup EXIT

SERIAL_DEV=""
for i in {1..20}; do
    SERIAL_DEV=$(grep -o '/dev/pts/[0-9]*' "$SOCAT_LOG" | tail -1)
    [ -n "$SERIAL_DEV" ] && break
    sleep 1
done

if [ -z "$SERIAL_DEV" ]; then
    printf "Failed to detect PTY device from socat.\n"
    if kill -0 "$SOCAT_PID" 2>/dev/null; then
        kill "$SOCAT_PID"
    fi
    exit 1
fi

printf "Emulator running on port %s\n" "$PORT"
printf "Serial emulated at: %s\n" "$SERIAL_DEV"

# Initialize temperatures as integers in tenths of a degree.
# Range 100..900 represents 10.0..90.0 degC.
for i in $(seq 0 31); do
    temps[$i]=$(( 100 + RANDOM % 800 ))
done

# Generate a new temperature for one channel using bash integer arithmetic.
# This replaces the original bc-based implementation which spawned 3 external
# processes per channel per cycle (96 bc calls per full 32-channel sweep).
function generate_temp
{
    local idx=$1
    local cur=${temps[$idx]}

    # Random change in range -7..+7 tenths of a degree
    local delta=$(( (RANDOM % 15) - 7 ))
    local new=$(( cur + delta ))

    # Clamp to 100..900 (10.0..90.0 degC)
    (( new < 100 )) && new=100
    (( new > 900 )) && new=900

    temps[$idx]=$new
    printf "%d.%d\n" $(( new / 10 )) $(( new % 10 ))
}

# Main loop: update and send temperature readings forever.
# Each generate_temp call completes in microseconds (no subprocess).
# Each channel updates at approximately the rate of one PTY write per iteration.
while true; do
    for i in $(seq 0 31); do
        val=$(generate_temp "$i")
        printf "CH%02d: %s\n" "$i" "$val" > "$SERIAL_DEV"
    done
    sleep 0.3
done
