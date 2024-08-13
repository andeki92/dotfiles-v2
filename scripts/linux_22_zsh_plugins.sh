#!/usr/bin/env bash

set -eu

# Resolve the current directory where the script is being executed
CURRENT_DIR="$(dirname "$(realpath "$0")")"
LIB_DIR="$CURRENT_DIR/common"

# Load the log_library
source $LIB_DIR/log.sh

if [ ! -d ~/.config/zsh/plugins/zsh-defer ]; then
    log_info "🥱 Installing zsh-defer" "zsh-plugins"
    mkdir -p ~/.config/zsh/plugins
    git clone --depth 1 https://github.com/romkatv/zsh-defer.git ~/.config/zsh/plugins/zsh-defer
fi
