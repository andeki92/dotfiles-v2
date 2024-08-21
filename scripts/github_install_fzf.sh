#!/usr/bin/env bash

# Title: Fzf installer
# Emoji: 🔍

set -eu

# Resolve the current directory where the script is being executed
CURRENT_DIR="$(dirname "$(realpath "$0")")"
LIB_DIR="$CURRENT_DIR/common"

# Load the log_library
source $LIB_DIR/log.sh

if ! command -v fzf &>/dev/null; then
    if [ ! -d "$HOME/.fzf" ]; then
        log_info "🤠 Installing fzf" "git-dependencies"
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install --key-bindings --completions --update-rc --no-bash --no-fish
    else
        log_info "⚠️ fzf directory already exists. Skipping installation." "git-dependencies"
    fi
fi
