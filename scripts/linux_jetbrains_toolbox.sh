#!/usr/bin/env bash

# Title:  JetBrains Toolbox installer
# Emoji: 🛠️

#!/bin/bash

set -e
set -o pipefail

# Resolve the current directory where the script is being executed
CURRENT_DIR="$(dirname "$(realpath "$0")")"
LIB_DIR="$CURRENT_DIR/common"

# Load the log_library
source $LIB_DIR/log.sh

TMP_DIR="/tmp"
INSTALL_DIR="$HOME/.local/share/JetBrains/Toolbox/bin"
SYMLINK_DIR="$HOME/.local/bin"

if ! command -v 'jetbrains-toolbox' &>/dev/null; then
    log_info "📦 Installing JetBrains toolbox"

    ARCHIVE_URL=$(curl -s 'https://data.services.jetbrains.com/products/releases?code=TBA&latest=true&type=release' | grep -Po '"linux":.*?[^\\]",' | awk -F ':' '{print $3,":"$4}' | sed 's/[", ]//g')
    ARCHIVE_FILENAME=$(basename "$ARCHIVE_URL")

    log_info "📥 Downloading $ARCHIVE_FILENAME..."
    rm "$TMP_DIR/$ARCHIVE_FILENAME" 2>/dev/null || true
    wget -q --show-progress -cO "$TMP_DIR/$ARCHIVE_FILENAME" "$ARCHIVE_URL"

    log_info "🏗️ Extracting to $INSTALL_DIR..."
    mkdir -p "$INSTALL_DIR"
    rm "$INSTALL_DIR/jetbrains-toolbox" 2>/dev/null || true
    tar -xzf "$TMP_DIR/$ARCHIVE_FILENAME" -C "$INSTALL_DIR" --strip-components=1
    rm "$TMP_DIR/$ARCHIVE_FILENAME"
    chmod +x "$INSTALL_DIR/jetbrains-toolbox"

    log_info "🔗 Symlinking to $SYMLINK_DIR/jetbrains-toolbox..."
    mkdir -p $SYMLINK_DIR
    rm "$SYMLINK_DIR/jetbrains-toolbox" 2>/dev/null || true
    ln -s "$INSTALL_DIR/jetbrains-toolbox" "$SYMLINK_DIR/jetbrains-toolbox"

    log_info "✨ Running for the first time to set-up..."
    ("$INSTALL_DIR/jetbrains-toolbox" &)
    log_info "\n✅ Done! JetBrains Toolbox is installed and running in the background! If not, run 'jetbrains-toolbox' (ensure that $SYMLINK_DIR is on your PATH)\n"
fi
