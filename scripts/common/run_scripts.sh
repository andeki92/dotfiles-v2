#!/usr/bin/env bash

# Resolve the current directory where the script is being executed
CURRENT_DIR="$(dirname "$(realpath "$0")")"
SCRIPTS_DIR="$CURRENT_DIR/../scripts"
LIB_DIR="$SCRIPTS_DIR/common"

# Load the log_library
source $LIB_DIR/log.sh

# Function to run scripts based on prefix
run_scripts() {
    local prefix="$1"
    local context="run_scripts"

    if [ -z "$prefix" ]; then
        log_error "❌ No prefix provided." "$context"
        usage
        return 1
    fi

    log_info "🔍 Finding and running ${prefix} scripts..." "$context"

    # Find and sort scripts with the given prefix
    scripts=$(find "$SCRIPTS_DIR" -type f -name "${prefix}*.sh" | sort)

    # Check if any scripts are found
    if [ -z "$scripts" ]; then
        log_error "❌ No ${prefix} scripts found in $SCRIPTS_DIR" "$context"
        return 1
    fi

    for script in $scripts; do
        script_name=$(basename "$script")
        log_info "⏳ Running $script_name..."
        chmod +x "$script"
        if "$script"; then
            log_info "✅ $script_name completed successfully!" "$context"
        else
            log_error "❌ $script_name failed. Stopping execution of remaining scripts." "$context"
            return 1
        fi
    done

    log_info "🎉 All ${prefix} scripts executed successfully!" "$context"
}

# Export the function for external usage
export -f run_scripts
