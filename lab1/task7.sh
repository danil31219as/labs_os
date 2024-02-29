#!/bin/bash

cd /etc
> emails.lst

grep -h -o -E '\b[A-Za-z0-9.]+@[A-Za-z0-9.]+\.[A-Z|a-z]{2,}\b' * >> emails.lst
