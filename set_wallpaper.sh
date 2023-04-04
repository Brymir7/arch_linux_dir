#!/bin/bash

# Open a new terminal and prompt the user for a search term
$TERM -- bash -c 'read -p "Enter a search term: " search_term; search_term=$(echo "$search_term" | tr " " "+"); $HOME/.scripts/wallpaper_api_request.sh "$search_term"; sleep 1'

# Close the terminal window
xdotool key "alt+F4"
