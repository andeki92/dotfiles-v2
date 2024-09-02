#!/usr/bin/env bash

# Title: Krew setup
# Emoji: 🤼

#!/bin/bash

set -e
set -o pipefail

# Resolve the current directory where the script is being executed
CURRENT_DIR="$(dirname "$(realpath "$0")")"
LIB_DIR="$CURRENT_DIR/common"

# Load the log_library
source $LIB_DIR/log.sh

if ! command -v 'kubectl krew' &>/dev/null; then
    log_info "🎒 Installing krew" "krew"

    (
        set -x; cd "$(mktemp -d)" &&
        OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
        ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
        KREW="krew-${OS}_${ARCH}" &&
        curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
        tar zxvf "${KREW}.tar.gz" &&
        ./"${KREW}" install krew
    )
fi

if ! command -v 'kubectl ns' &>/dev/null; then
    log_info "📛 Installing krew ns" "krew"
    kubectl krew install ns
fi

if ! command -v 'kubectl ctx' &>/dev/null; then
    log_info "🧃 Installing krew ctx" "krew"
    kubectl krew install ctx
fi
