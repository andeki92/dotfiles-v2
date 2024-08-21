#!/usr/bin/env bash

# Title: starship installer/updater
# Emoji: 🚀

set -eu

# Resolve the current directory where the script is being executed
CURRENT_DIR="$(dirname "$(realpath "$0")")"
LIB_DIR="$CURRENT_DIR/common"

# Load the log_library
source $LIB_DIR/log.sh

if ! command -v starship &>/dev/null; then
    log_info "🚀 Installing starship" "curl-packages"
    curl -sS https://starship.rs/install.sh | sh -s -- -y
else
    log_info "🚀 Updating starship" "curl-packages"
    curl -sS https://starship.rs/install.sh | sh -s -- -y
fi
