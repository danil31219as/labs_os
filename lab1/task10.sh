#!/bin/bash

man_text=$(man bash)

filtered_text=$(echo "$man_text" | tr -s '[:space:]' '\n' | grep -E '\b\w{4,}\b' | tr '[:upper:]' '[:lower:]')
result=$(echo "$filtered_text" | sort | uniq -c | sort -nr | head -n 3)

echo "$result"
