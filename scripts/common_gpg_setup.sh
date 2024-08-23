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
    log_info "🔓 GnuPG is installed but no keys are set up."

    log_info "1️⃣  First, use selection 9 (ECC and ECC)."
    log_info "2️⃣  Second, use selection 5 (NIST P-521)."
    log_info "3️⃣  Third, set expiration to 2 years (2y)."
    log_info "4️⃣  Lastly, set the correct user IDs."


    log_info "📋 Remember to run 'gpg --expert --full-generate-key'"
    # --expert to allow for ECDSA keys
    # gpg --expert --full-generate-key

    # decrypt the git-crypt directories if not already decrypted
    gpg --import $CURRENT_DIR/../secrets/gpg/private_keys.asc
    gpg --import $CURRENT_DIR/../secrets/gpg/pub_keys.asc
    gpg -K
    gpg -k

    gpg --import-ownertrust $CURRENT_DIR/../secrets/gpg/otrust.txt

    exit 1
else
    log_info "🔒 GnuPG is set up."
fi
