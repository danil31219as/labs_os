#!/bin/bash

COMMAND_DIR="/sbin"
pids=$(ps -eo pid,cmd | grep "^ *[0-9]* ${COMMAND_DIR}/" | awk '{print $1}')

echo "$pids" > task2_output.txt
