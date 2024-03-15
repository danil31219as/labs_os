#!/bin/bash

get_bytes_read() {
    pid=$1
    read_bytes=$(grep "read_bytes" /proc/$pid/io | awk '{print $2}')
    echo $read_bytes
}

get_command_line() {
    pid=$1
    command_line=$(ps -p $pid -o cmd=)
    echo $command_line
}

declare -A initial_bytes
for pid_dir in /proc/[0-9]*; do
    pid=$(basename "$pid_dir")
    initial_bytes[$pid]=$(get_bytes_read $pid)
done

sleep 60

declare -A final_bytes
for pid_dir in /proc/[0-9]*; do
    pid=$(basename "$pid_dir")
    final_bytes[$pid]=$(get_bytes_read $pid)
done

declare -A byte_diffs
for pid in "${!initial_bytes[@]}"; do
    initial=${initial_bytes[$pid]}
    final=${final_bytes[$pid]}
    byte_diffs[$pid]=$((final - initial))
done

sorted_pids=($(for pid in "${!byte_diffs[@]}"; do echo "$pid"; done | sort -nrk2 | head -n 3))

for pid in "${sorted_pids[@]}"; do
    command_line=$(get_command_line $pid)
    byte_diff=${byte_diffs[$pid]}
    echo "$pid:$command_line:$byte_diff"
done
