#!/usr/bin/env bash
set -e

REPO="zolduck0/yt-fzf"
FILE="yt-fzf.sh"
RENAME="yt-fzf"
URL="https://github.com/$REPO/releases/latest/download/$FILE"
INSTALL="$HOME/.local/bin/$FILE"
INSTALL_RENAME="$HOME/.local/bin/$RENAME"
CONFIG="$HOME/.config/yt-fzf"
CONFIG_FILE="$CONFIG/config"

echo "Downloading yt-fzf..."
curl -L "$URL" -o "$INSTALL"
mv "$INSTALL" "$INSTALL_RENAME"
chmod +x "$INSTALL_RENAME"

echo "yt-fzf installed! Creating .config folder..."
mkdir -p "$CONFIG"

echo "Creating config file..."
echo "DOWNLOAD_DIR=\"$HOME\"" >"$CONFIG_FILE"
echo "Done! yt-fzf is installed."
echo "A configuration file was created at $CONFIG_FILE. You can alter DOWNLOAD_DIR to specify where you want downloaded videos to go."
echo
echo "Have a great day!"
