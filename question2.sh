#!/bin/bash

# Check if a directory is provided as an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 path_to_directory"
    exit 1
fi

DIR=$1

# Check if the directory exists and is readable
if [ ! -d "$DIR" ] || [ ! -r "$DIR" ]; then
    echo "Error: Directory does not exist or is not readable"
    exit 1
fi

# Use associative array to store file types and their counts
declare -A file_types

# Traverse the directory recursively and count file types
while IFS= read -r -d '' file; do
    ext="${file##*.}"
    if [ "$ext" != "$file" ]; then
        ((file_types[$ext]++))
    else
        ((file_types["no_extension"]++))
    fi
done < <(find "$DIR" -type f -print0)

# Print the sorted list of file types along with their counts
for ext in "${!file_types[@]}"; do
    echo "$ext: ${file_types[$ext]}"
done | sort

exit 0