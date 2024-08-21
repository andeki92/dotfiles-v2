#!/usr/bin/env bash

# Resolve the current directory where the script is being executed
CURRENT_DIR="$(dirname "$(realpath "$0")")"
LIB_DIR="$CURRENT_DIR/../scripts/common"

# source the libraries
source $LIB_DIR/run_scripts.sh

log_info "⌛ Starting the installation process for Linux."

# Run the common scripts
if run_scripts "common_"; then
    log_info "🏆 All common scripts executed successfully."
else
    log_error "🔥 One or more common scripts failed to execute."
fi

# Run the linux scripts
if run_scripts "linux_"; then
    log_info "🏆 All linux scripts executed successfully."
else
    log_error "🔥 One or more linux scripts failed to execute."
fi

stow tmux starship zsh git git-wsl
