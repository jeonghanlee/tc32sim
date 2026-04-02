#!/usr/bin/env bash
#
#  Verify that all TC-32 emulator instances are running and streaming data.
#
for n in $(seq -f "%03g" 1 64); do
    pvxget -r "device.model" TC32:${n}:group
done


pvxget TC32:001:group

for n in $(seq -f "%03g" 1 64); do
    pvxget -r "ch00.temp" TC32:${n}:group 2>/dev/null | grep -v "^$"
done
