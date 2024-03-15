#!/bin/bash

# Function to calculate the mean of an array of numbers
calculate_mean() {
    local sum=0
    local count=0
    for num in "$@"; do
        sum=$((sum + num))
        count=$((count + 1))
    done
    echo "scale=2; $sum / $count" | bc
}

input_file="task4_output.txt"

while IFS= read -r line; do
    pid=$(echo "$line" | awk -F'[: ]+' '{print $2}')
    ppid=$(echo "$line" | awk -F'[: ]+' '{print $4}')
    art=$(echo "$line" | awk -F'[: ]+' '{print $6}')

    grouped_art["$ppid"]+=" $art"
done < "$input_file"

for ppid in "${!grouped_art[@]}"; do
    mean=$(calculate_mean ${grouped_art["$ppid"]})
    echo "PPID=$ppid : ART=$mean" >> "task5_output.txt"
done
