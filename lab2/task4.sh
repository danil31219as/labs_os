#!/bin/bash

output_file="task4_output.txt"

for pid_dir in /proc/[0-9]*/; do
    pid=$(basename "$pid_dir")
    status_file="$pid_dir/status"
    sched_file="$pid_dir/sched"

    if [ -f "$status_file" ] && [ -f "$sched_file" ]; then

        process_id=$(grep -E '^Pid:' "$status_file" | awk '{print $2}')
        parent_process_id=$(grep -E '^PPid:' "$status_file" | awk '{print $2}')

        sum_exec_runtime=$(grep -E '^se\.sum_exec_runtime' "$sched_file" | awk '{print $3}')
        nr_switches=$(grep -E '^nr_switches' "$sched_file" | awk '{print $3}')

        if [ "$nr_switches" -gt 0 ]; then
            avg_running_time=$(echo "scale=6; $sum_exec_runtime / $nr_switches" | bc)
        else
            avg_running_time=0
        fi

        echo "ProcessID=$process_id : Parent_ProcessID=$parent_process_id : Average_Running_Time=$avg_running_time" >> "$output_file"
    fi
done

sort -t '=' -k 4 -n -o "$output_file" "$output_file"
