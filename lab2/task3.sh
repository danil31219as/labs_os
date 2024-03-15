#!/bin/bash

last_pid=$(ps -eo pid,etimes --sort=start_time | tail -n 1 | awk '{print $1}')
echo "Last started process PID: $last_pid"
