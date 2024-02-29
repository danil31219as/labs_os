#!/bin/bash

while true; do
    echo "1. Запустить nano"
    echo "2. Запустить vi"
    echo "3. Запустить браузер links"
    echo "4. Выйти из меню"
    read "Выберите пункт меню: " choice

    case $choice in
        1)
            nano
            ;;
        2)
            vi
            ;;
        3)
            links
            ;;
        4)
            exit 0
            ;;
    esac
done
