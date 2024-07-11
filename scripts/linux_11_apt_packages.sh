#!/usr/bin/env bash

set -eu

# Resolve the current directory where the script is being executed
CURRENT_DIR="$(dirname "$(realpath "$0")")"
LIB_DIR="$CURRENT_DIR/common"

# Load the log_library
source $LIB_DIR/log.sh

wanted_packages=(
    git
    curl
    build-essential
    zsh
    tmux
    bat
    fzf
)

sudo apt install --yes --no-install-recommends "${wanted_packages[@]}"
