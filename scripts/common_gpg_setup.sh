#!/usr/bin/env bash

# Title: GnuPG setup
# Emoji: 🔐

#!/bin/bash

set -e
set -o pipefail

# Resolve the current directory where the script is being executed
CURRENT_DIR="$(dirname "$(realpath "$0")")"
LIB_DIR="$CURRENT_DIR/common"

# Load the log_library
source $LIB_DIR/log.sh

# Check if GPG is installed
if ! command -v gpg &> /dev/null; then
    log_info "☠️ GnuPG is not installed. Please install 'gpg' first."
    exit 1
fi

# if there is no .gnupg directory and you run gpg --list-keys it will create
# said directory and output some stuff. We therefor run the command twice
# and only care about the output of the second one
gpg --list-keys &> /dev/null

# Check for existing GPG keys
keys=$(gpg --list-keys)

# Check if the keys variable is empty
if [ -z "$keys" ]; then
    git-crypt unlock # ensure the vault is unlocked

    # decrypt the git-crypt directories if not already decrypted
    gpg --import $CURRENT_DIR/../secrets/gpg/private_keys.asc
    gpg --import $CURRENT_DIR/../secrets/gpg/public_keys.asc
    gpg --import-ownertrust $CURRENT_DIR/../secrets/gpg/otrust.txt

    exit 1
else
    log_info "🔒 GnuPG is set up."
fi
