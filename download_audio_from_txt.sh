#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 <input_file> <output_directory>"
    exit 1
fi

input_file="$1"
output_directory="$2"

if [ ! -d "$output_directory" ]; then
    echo "Error: $output_directory is not a directory"
    exit 1
fi

while IFS= read -r url; do
    echo "Downloading video from $url"
    bash download_audio.sh "$url" "$output_directory"
    echo "Done downloading video from $url"
done < "$input_file"
