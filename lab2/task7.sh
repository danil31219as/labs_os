#!/bin/bash

# Функция для получения суммарного количества считанных байт для процесса
get_bytes_read() {
    pid=$1
    # Используем procfs для получения информации о процессе
    read_bytes=$(grep "read_bytes" /proc/$pid/io | awk '{print $2}')
    echo $read_bytes
}

# Функция для получения строки запуска процесса
get_command_line() {
    pid=$1
    # Используем команду ps для получения строки запуска процесса
    command_line=$(ps -p $pid -o cmd=)
    echo $command_line
}

# Получаем начальные значения считанных байт для всех процессов
declare -A initial_bytes
for pid in $(pidof -x $0); do
    initial_bytes[$pid]=$(get_bytes_read $pid)
done

# Ждем 1 минуту
sleep 60

# Получаем конечные значения считанных байт и вычисляем разницу
declare -A final_bytes
for pid in $(pidof -x $0); do
    final_bytes[$pid]=$(get_bytes_read $pid)
done

# Вычисляем разницу в считанных байтах для каждого процесса
declare -A byte_diffs
for pid in "${!initial_bytes[@]}"; do
    initial=${initial_bytes[$pid]}
    final=${final_bytes[$pid]}
    byte_diffs[$pid]=$((final - initial))
done

# Сортируем процессы по убыванию разницы в считанных байтах и выводим топ-3
sorted_pids=($(for pid in "${!byte_diffs[@]}"; do echo "$pid"; done | sort -nrk2 | head -n 3))

# Выводим информацию о топ-3 процессах
for pid in "${sorted_pids[@]}"; do
    command_line=$(get_command_line $pid)
    byte_diff=${byte_diffs[$pid]}
    echo "$pid:$command_line:$byte_diff"
done
