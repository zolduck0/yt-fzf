#!/usr/bin/env bash

API_FILE="$HOME/.config/yt-fzf/API.txt"
if [ ! -f "$API_FILE" ]; then
  echo "No API file found."
  exit 1
fi

API_KEY=$(tr -d ' \n\r' <"$API_FILE")
MODE="VIDEO"

case "$1" in
-a)
  MODE="AUDIO"
  ;;
-h)
  echo "yt-fzf [option]"
  echo "yt-fzf - Downloads videos."
  echo "-a - Downloads audio only."
  echo "-h for help."
  exit 1
  ;;
esac

read -p "Search for videos: " QUERY

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

ARGUMENT=""
case "$MODE" in
"VIDEO")
  ARGUMENT="-t mp4"
  ;;
"AUDIO")
  ARGUMENT="-x --audio-format mp3"
  ;;
esac

echo "ARGUMENT: $ARGUMENT"

if [ -n "$videoId" ]; then
  args=($ARGUMENT)
  yt-dlp "${args[@]}" -o "$DOWNLOAD_DIR/%(title)s.%(ext)s" "https://www.youtube.com/watch?v=$videoId"
else
  echo "Invalid video id."
  exit 1
fi
