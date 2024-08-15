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
    stow
    build-essential
    zsh
    tmux
    bat
    eza
    fd-find
    git-delta
    ripgrep
    preload # faster startup times
)

dependencies=(
    mesa-utils # required by jetbrains toolbox
)

# Preliminary eza-checks
if ! command -v eza &>/dev/null; then
    sudo mkdir -p /etc/apt/keyrings
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
fi

sudo apt install --yes --no-install-recommends "${wanted_packages[@]}"
sudo apt install --yes --no-install-recommends "${dependencies[@]}"

# Symlink fdfind as fd
if ! command -v fd &>/dev/null; then
    ln -s $(which fdfind) ~/.local/bin/fd
fi
