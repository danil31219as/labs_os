#!/bin/bash

get_io_info() {
    awk '{print $1":"$2}' /proc/*/io 2>/dev/null | grep -E '^[0-9]+:' | sed 's|/proc/||;s|/io:|:|'
}

start_info=$(get_io_info)

sleep 60

end_info=$(get_io_info)

join -t: -1 1 -2 1 <(echo "$start_info") <(echo "$end_info") | \
    awk -F: '{print $1":"$2":"$4-$3}' | \
    sort -t: -k3 -nr | head -n 3
