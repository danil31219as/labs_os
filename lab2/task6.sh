#!/bin/bash

max_mem=0
max_pid=""
for pid in $(ls /proc | grep -E '^[0-9]+$'); do
    mem=$(awk '/VmRSS:/ {print $2}' /proc/$pid/status)
    if [[ -n $mem ]]; then
        if (( mem -gt max_mem )); then
            max_mem=$mem
            max_pid=$pid
        fi
    fi
done

if [[ -n $max_pid ]]; then
    echo "Process with the most RAM allocated (via /proc):"
    echo "PID: $max_pid"
    echo "RAM: $max_mem"
else
    echo "No processes found."
fi

top_output=$(top -b -n 1 | grep -E '^ *PID' -A $(($(tput lines) - 1)) | tail -n +2 | sort -k10 -r)

echo "Top command reports total RAM usage: $(echo "$top_output" | head -n 1 | awk '{print $10}')"
