#!/bin/bash

# Check if a log file is provided as an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 path_to_log_file"
    exit 1
fi

LOG_FILE=$1

# Check if the log file exists and is readable
if [ ! -f "$LOG_FILE" ] || [ ! -r "$LOG_FILE" ]; then
    echo "Error: Log file does not exist or is not readable"
    exit 1
fi

# Total Requests Count
total_requests=$(wc -l < "$LOG_FILE")
echo "Total Requests Count: $total_requests"

# Percentage of Successful Requests (HTTP status codes in the range 200-299)
successful_requests=$(awk '$9 ~ /^2[0-9][0-9]$/' "$LOG_FILE" | wc -l)
percentage_successful=$(awk "BEGIN {printf \"%.2f\", ($successful_requests / $total_requests) * 100}")
echo "Percentage of Successful Requests: $percentage_successful%"

# Most Active User (IP address with the most requests)
most_active_user=$(awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -n 1 | awk '{print $2}')
echo "Most Active User: $most_active_user"

exit 0