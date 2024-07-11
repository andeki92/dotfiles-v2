#!/usr/bin/env bash

INFO="INFO"
ERROR="ERROR"

# Color codes
COLOR_RESET="\033[0m"
COLOR_INFO="\033[1;34m"
COLOR_ERROR="\033[1;31m"

# Function to log info messages
log_info() {
    local message="$1"
    local context="${2:-}"
    local log_message
    if [ "$DEBUG_MODE" == "true" ]; then
        log_message="[$(date +'%Y-%m-%d %H:%M:%S')] [$INFO] [$context] $message"
    else
        log_message="$COLOR_INFO$message$COLOR_RESET"
    fi
    echo -e "$log_message"
}

# Function to log error messages
log_error() {
    local message="$1"
    local context="${2:-}"
    local log_message
    if [ "$DEBUG_MODE" == "true" ]; then
        log_message="[$(date +'%Y-%m-%d %H:%M:%S')] [$ERROR] [$context] $message"
    else
        log_message="$COLOR_ERROR$message$COLOR_RESET"
    fi
    echo -e "$log_message" >&2
}
