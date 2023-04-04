#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 <input_directory> <output_directory>"
    exit 1
fi

input_directory="$1"
output_directory="$2"

if [ ! -d "$input_directory" ]; then
    echo "Error: $input_directory is not a directory"
    exit 1
fi

if [ ! -d "$output_directory" ]; then
    echo "Creating directory $output_directory"
    mkdir -p "$output_directory"
fi

for file in "$input_directory"/*.mp3; do
    filename=$(basename "$file")
    filename="${filename%.*}"

    echo "Transcribing $file"
    whisper --language English --threads 15 --model base -o "$output_directory" "$file" 
    echo "Transciing $file success!"
echo "Cleaning up dir"
rm -f *.json *.tsv *.srt *.vtt
done
