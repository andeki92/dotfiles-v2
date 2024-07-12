#!/usr/bin/env bash

set -eu

# Resolve the current directory where the script is being executed
CURRENT_DIR="$(dirname "$(realpath "$0")")"
LIB_DIR="$CURRENT_DIR/common"

# Load the log_library
source $LIB_DIR/log.sh

if ! command -v fzf &>/dev/null; then
    log_info "🤠 Installing fzf" "git-dependencies"
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
fi

if ! command -v zsh-defer &>/dev/null; then
    log_info "🥱 Installing zsh-defer" "git-dependencies"
    mkdir -p ~/.config/zsh/plugins
    git clone --depth 1 https://github.com/romkatv/zsh-defer.git ~/.config/zsh/plugins/zsh-defer
fi
