#!/bin/bash

cd /etc
> emails.lst

find . -type f -exec grep -h -o -E '\b[A-Za-z0-9.]+@[A-Za-z0-9.]+\.[A-Z|a-z]{2,}\b' {} + >> emails.lst
