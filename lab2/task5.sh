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
last_ppid=0
sum=0
count=0
while IFS= read -r line; do
    pid=$(echo "$line" | awk -F'[: ]+' '{print $2}')
    ppid=$(echo "$line" | awk -F'[: ]+' '{print $4}')
    art=$(echo "$line" | awk -F'[: ]+' '{print $6}')
    if [$ppid -eq $last_ppid]; then 
        sum=$((sum + art)) 
        count=$((count + 1))
    else 
        mean=$(echo "scale=2; $sum / $count" | bc)
        echo "PPID=$ppid : ART=$mean" >> "task5_output.txt"
        last_ppid=$ppid 
        sum=$art 
        count=1;
    fi
    
done < "$input_file"
mean=$(echo "scale=2; $sum / $count" | bc)
echo "PPID=$ppid : ART=$mean" >> "task5_output.txt"
