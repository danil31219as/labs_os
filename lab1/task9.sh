#!/bin/bash

directory="/var/log/"

total_lines=$(find "$directory" -name "*.log" -exec cat {} + | wc -l)

echo "Общее количество строк в файлах с расширением .log в директории $directory: $total_lines"
