#!/usr/bin/env bash

# Title: GnuPG WSL setup
# Emoji: 🤖

#!/bin/bash

set -e
set -o pipefail

# Resolve the current directory where the script is being executed
CURRENT_DIR="$(dirname "$(realpath "$0")")"
LIB_DIR="$CURRENT_DIR/common"

# Load the log_library
source $LIB_DIR/log.sh

gpg_conf="$HOME/.gnupg/gpg.conf"
gpg_agent_conf="$HOME/.gnupg/gpg-agent.conf"

# Define the required lines
conf_required_lines=("use-agent" "pinentry-mode loopback")
agent_conf_required_lines=("allow-loopback-pinentry")

# if there is no .gnupg directory and you run gpg --list-keys it will create
# said directory wich is required before we run any commands in that dir
gpg --list-keys &> /dev/null

add_file_if_missing() {
    local file="$1"

    if ! [ -e "$file" ] ; then
        touch "$file"
    fi
}

add_line_if_missing() {
    local line="$1"
    local file="$2"
    grep -qF -- "$line" "$file" || echo "$line" >> "$file"
}

for line in "${conf_required_lines[@]}"; do
    add_file_if_missing "$gpg_conf"
    add_line_if_missing "$line" "$gpg_conf"
done

log_info "🔐 $gpg_conf is up to date"

for line in "${agent_conf_required_lines[@]}"; do
    add_file_if_missing "$gpg_agent_conf"
    add_line_if_missing "$line" "$gpg_agent_conf"
done

log_info "🤖 $gpg_agent_conf is up to date"
