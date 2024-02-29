#!/bin/bash

output_file="info.log"

syslog_file="/var/log/anaconda/syslog"

if [ -e "$output_file" ]; then
    echo "Файл $output_file уже существует."
    exit 1
fi

awk '$2 == "INFO"' "$syslog_file" > "$output_file"

echo "Сохранено"
