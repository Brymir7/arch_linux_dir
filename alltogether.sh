#!/bin/bash

echo "downloading audio files"
download_audio_from_txt.sh "a.txt" "audio_files"
echo "finished downloading audio files"
echo "converting audio to text files"
convert_audio_to_txt.sh "audio_files" "txt_files"
echo "finished converting audio to text files"
echo "cleaning directory"
clean_dir.sh "txt_files"
echo "finished cleaning directory"
