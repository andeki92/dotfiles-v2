#!/usr/bin/env bash

# Title: apt install auto-upgrader
# Emoji: 🔄

set -eu

# Resolve the current directory where the script is being executed
CURRENT_DIR="$(dirname "$(realpath "$0")")"
LIB_DIR="$CURRENT_DIR/common"

# Load the log_library
source $LIB_DIR/log.sh

sudo apt install unattended-upgrades
