#!/usr/bin/env bash
#
#  Verify that all TC-32 emulator instances are running and streaming data.
#
#  Usage:
#    ./check_simulators.bash              check all 64 ports (9400-9463)
#    ./check_simulators.bash --port 9400  check a single port
#    ./check_simulators.bash --first 5    check only the first 5 devices
#

BASE_PORT=9400
NUM_DEVICES=64
TIMEOUT=2

PASS=0
FAIL=0
SINGLE_PORT=""
FIRST_N=""

while [[ $# -gt 0 ]]; do
    case $1 in
        --port)  SINGLE_PORT="$2"; shift 2 ;;
        --first) FIRST_N="$2";     shift 2 ;;
        *) printf "Unknown option: %s\n" "$1"; exit 1 ;;
    esac
done

function check_port
{
    local port=$1
    local device=$2

    local line
    line=$(nc -w "$TIMEOUT" -q 1 localhost "$port" 2>/dev/null | head -1)

    if [[ -z "$line" ]]; then
        printf "FAIL  device %03d  port %d  no data\n" "$device" "$port"
        FAIL=$((FAIL + 1))
        return
    fi

    if [[ "$line" =~ ^CH[0-9]{2}:\ [-0-9.]+ ]]; then
        printf "OK    device %03d  port %d  %s\n" "$device" "$port" "$line"
        PASS=$((PASS + 1))
    else
        printf "FAIL  device %03d  port %d  unexpected: %s\n" "$device" "$port" "$line"
        FAIL=$((FAIL + 1))
    fi
}

SEP="------------------------------------------------------------"

if [[ -n "$SINGLE_PORT" ]]; then
    device=$(( SINGLE_PORT - BASE_PORT + 1 ))
    printf "%s\n" "$SEP"
    check_port "$SINGLE_PORT" "$device"
    printf "%s\n" "$SEP"
    exit 0
fi

limit=${FIRST_N:-$NUM_DEVICES}

printf "%s\n" "$SEP"
printf "Checking %d emulator instances (timeout %ds per port)\n" "$limit" "$TIMEOUT"
printf "%s\n" "$SEP"

for i in $(seq 1 "$limit"); do
    port=$(( BASE_PORT + i - 1 ))
    check_port "$port" "$i"
done

printf "%s\n" "$SEP"
printf "Result: %d OK  %d FAIL  (total %d)\n" "$PASS" "$FAIL" "$limit"
printf "%s\n" "$SEP"

[[ $FAIL -eq 0 ]]
