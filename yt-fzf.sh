#!/usr/bin/env bash

API_FILE="$HOME/.config/yt-fzf/API.txt"
if [ ! -f "$API_FILE" ]; then
  echo "No API file found."
  exit 1
fi

API_KEY=$(tr -d ' \n\r' <"$API_FILE")

if [ -z "$1" ]; then
  read -p "Search for videos: " QUERY
else
  QUERY="$*"
fi

response=$(curl -s "https://www.googleapis.com/youtube/v3/search?part=snippet&type=video&maxResults=20&q=${QUERY// /+}&key=$API_KEY")

if echo "$response" | grep -q '"error"'; then
  echo "API error."
  echo "$response" | jq '.error.message'
  exit 1
fi

mapfile -t results < <(echo "$response" | jq -r '.items[] | "\(.snippet.title) | \(.id.videoId)"')

if [ ${#results[@]} -eq 0 ]; then
  echo "No videos found."
  exit 1
fi

selection=$(printf "%s\n" "${results[@]}" | fzf-tmux -p --reverse --prompt="Choose a video to download: ")

if [ -z "$selection" ]; then
  echo "No videos found."
  exit 1
fi

videoId=$(echo "$selection" | awk -F'|' '{print $2}' | xargs)

CONFIG_FILE="$HOME/.config/yt-fzf/config"
DOWNLOAD_DIR=$(grep '^DOWNLOAD_DIR=' "$CONFIG_FILE" | cut -d'=' -f2- | xargs)

if [ -z "$DOWNLOAD_DIR" ]; then
  echo "Download directory missing or invalid, downloading on current folder..."
  DOWNLOAD_DIR="."
fi

if [ -n "$videoId" ]; then
  yt-dlp -x --audio-format mp3 -o "$DOWNLOAD_DIR/%(title)s.%(ext)s" "https://www.youtube.com/watch?v=$videoId"
else
  echo "Invalid video id."
  exit 1
fi
