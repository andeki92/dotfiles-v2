#!/usr/bin/env bash

set -eu

# Resolve the current directory where the script is being executed
CURRENT_DIR="$(dirname "$(realpath "$0")")"
LIB_DIR="$CURRENT_DIR/common"

# Load the log_library
source $LIB_DIR/log.sh

if [ ! $(asdf plugin list | grep 'kubectl') ]; then
    log_info "⛵ Installing kubectl asdf plugin" "asdf plugins"
    asdf plugin-add kubectl https://github.com/asdf-community/asdf-kubectl.git
fi
