#!/usr/bin/env bash

API_KEY=''
QUERY="$1"

response=$(curl -s "https://www.googleapis.com/youtube/v3/search?part=snippet&type=video&maxResults=20&q=${QUERY// /+}&key=$API_KEY")

mapfile -t results < <(echo "$response" | jq -r '.items[] | "\(.snippet.title) | \(.id.videoId)"')

selection=$(printf "%s\n" "${results[@]}" | fzf --prompt="Choose a video to download: ")
videoId=$(echo "$selection" | awk -F'|' '{print $2}' | xargs)

yt-dlp -x --audio-format mp3 "https://www.youtube.com/watch?v=$videoId"
