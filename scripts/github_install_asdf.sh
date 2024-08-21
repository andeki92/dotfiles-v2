#!/usr/bin/env bash

# Title: ASDF Version Manager installer
# Emoji: 🔢

set -eu

# Resolve the current directory where the script is being executed
CURRENT_DIR="$(dirname "$(realpath "$0")")"
LIB_DIR="$CURRENT_DIR/common"

# Load the log_library
source $LIB_DIR/log.sh

if ! command -v asdf &>/dev/null; then
    if [ ! -d "$HOME/.asdf" ]; then
        log_info "🎁 Installing asdf" "git-dependencies"
        git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
        source "$HOME/.asdf/asdf.sh"
    else
        log_info "⚠️ asdf directory already exists. Skipping installation." "git-dependencies"
    fi
fi

if ! command -v asdf &>/dev/null; then
    # load asdf into the current shell
    source "$HOME/.asdf/asdf.sh"
fi

if [ ! $(asdf plugin list | grep 'kubectl') ]; then
    log_info "⛵ Installing kubectl asdf plugin" "asdf plugins"
    asdf plugin-add kubectl https://github.com/asdf-community/asdf-kubectl.git
fi

if [ ! $(asdf plugin list | grep 'kubectl') ]; then
    log_info "🐍 Installing kubectl asdf plugin" "asdf plugins"
    asdf plugin-add python
fi

if [ ! $(asdf plugin list | grep 'kubectl') ]; then
    log_info "☕ Installing java asdf plugin" "asdf plugins"
    asdf plugin-add java https://github.com/halcyon/asdf-java.git
fi

if [ ! $(asdf plugin list | grep 'kubectl') ]; then
    log_info "🧑‍💻 Installing kotlin asdf plugin" "asdf plugins"
    asdf plugin add kotlin https://github.com/asdf-community/asdf-kotlin.git
fi
