#!/bin/bash

current_directory=$(pwd)
home_directory=$HOME

if [ "$current_directory" = "$home_directory" ]; then
    echo "Текущая директория: $current_directory"
    exit 0
else
    echo "Ошибка"
    exit 1
fi
