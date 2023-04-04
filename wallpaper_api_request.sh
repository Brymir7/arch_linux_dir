#!/bin/bash

# Set your Wallhaven API key
API_KEY="NL9QZIkLZdZzglkk9JZl92r2axj21f0F"

# Get the search term from the command line argument
search_term=$1

# Make a request to the Wallhaven API to search for the most popular wallpapers with the given term
response=$(curl -s -H "Authorization: Bearer $API_KEY" "https://wallhaven.cc/api/v1/search?q=$search_term&sorting=toplist&order=desc")

# Extract the URLs of the top 20 wallpapers returned by the API
wallpaper_urls=$(echo "$response" | jq -r '.data[] | select(.purity=="sfw") | .path')
readarray -t wallpaper_urls_array <<< "$wallpaper_urls"
# Set the initial wallpaper to the first one in the list
current_wallpaper_index=0
current_wallpaper_url=$(echo "$wallpaper_urls" | sed -n "${current_wallpaper_index+1}p")
curl -s "$current_wallpaper_url" | feh --bg-fill -

while true; do
    # Display the current wallpaper information in the terminal
    echo "Current wallpaper: $current_wallpaper_url"
    echo "Enter a number to select a different wallpaper (1-20), or type 'confirm' to keep the current wallpaper:"

    # Read the user's input
    read input

    # If the user entered a number, set the corresponding wallpaper as the background
    if [[ "$input" =~ ^[1-9]$|^1[0-9]$|^20$ ]]; then
        current_wallpaper_index=$((input-1))
        current_wallpaper_url=${wallpaper_urls_array[$current_wallpaper_index]}
        curl -s "$current_wallpaper_url" | feh --bg-fill -

    # If the user entered 'confirm', exit the loop and keep the current wallpaper
    elif [[ "$input" == "confirm" ]]; then
        echo "Keeping current wallpaper: $current_wallpaper_url"
        break

    # If the user entered invalid input, display an error message
    else
        echo "Invalid input, please enter a number between 1 and 20, or type 'confirm'."
    fi
done
