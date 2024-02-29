#!/bin/bash

file="/etc/passwd"

user_info=$(cat "$file" | cut -d: -f1,3 | sort -t: -k2 -n)

echo "$user_info"
