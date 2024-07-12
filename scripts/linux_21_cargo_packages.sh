#!/usr/bin/env bash

set -eu

# Resolve the current directory where the script is being executed
CURRENT_DIR="$(dirname "$(realpath "$0")")"
LIB_DIR="$CURRENT_DIR/common"

# Load the log_library
source $LIB_DIR/log.sh

if ! command -v rustup &>/dev/null; then
    log_info "🦀 Installing rust" "cargo-packages"
    curl https://sh.rustup.rs -sSf | sh
    source $HOME/.cargo/bin
fi

if ! command -v navi &>/dev/null; then
    log_info "🧚 Installing navi" "cargo-packages"
    cargo install --locked navi
fi

if ! command -v btm &>/dev/null; then
    log_info "💹 Installing btm" "cargo-packages"
    cargo install bottom --locked
fi
