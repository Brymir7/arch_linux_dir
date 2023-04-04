#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 <url> <output_directory>"
    exit 1
fi

url="$1"
output_directory="$2"

if [ ! -d "$output_directory" ]; then
    echo "Error: $output_directory is not a directory"
    exit 1
fi

yt-dlp -x --audio-format mp3 -o "$output_directory/%(title)s.%(ext)s" "$url"

if [ "$?" -ne 0 ]; then
    echo "Error downloading video"
    exit 1
fi

echo "Video downloaded successfully!"
