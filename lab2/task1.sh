#!/bin/bash

username="user"

num_processes=$(ps -u $username | wc -l)
num_processes=$((num_processes - 1))

echo "$num_processes" > processes_count.txt

echo "PID:Command" > process_info.txt
ps -u $username | awk 'NR > 1 {print $1 ": " $5}' >> process_info.txt
