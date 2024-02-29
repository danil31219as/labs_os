#!/bin/bash

lines=()

while true
do
    read line
    
    if [ "$line" == "q" ]
    then
        break
    fi

    lines+=("$line")
done

echo "Последовательность строк: ${lines[*]}"
