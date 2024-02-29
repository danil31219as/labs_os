#!/bin/bash

source_file="/var/log/anaconda/X.log"

result_file="full.log"
> "$result_file"

grep "WARNING" "$source_file" | sed 's/\(WARNING\)/Warning: /' >> "$result_file"
grep "INFO" "$source_file" | sed 's/\(INFO\)/Information: /' >> "$result_file"
