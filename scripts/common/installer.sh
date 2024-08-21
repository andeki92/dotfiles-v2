#!/usr/bin/env bash

set -eu  # 'set -e' ensures the script exits on any error

# Resolve the current directory where the script is being executed
CURRENT_DIR="$(dirname "$(realpath "$0")")"
SCRIPT_DIR="$CURRENT_DIR/../../scripts"

# Get the hostname
HOSTNAME=$(hostname)

# Get the current date and time in YYYYMMDD_HHMMSS format
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Define the directory for log files
LOG_DIR="$CURRENT_DIR/../../.logs/$HOSTNAME"
# Create the logs directory if it doesn't exist
mkdir -p "$LOG_DIR"

# Define the log file for this run
LOG_FILE="$LOG_DIR/${TIMESTAMP}_${HOSTNAME}.log"
LOG_FILE_SHORT=$(basename "$LOG_FILE")

# Set the DEBUG_MODE to false for all scripts
export DEBUG_MODE=false

# Summary array to store the results
declare -a summary

# Default emoji and title if none are specified in the script
DEFAULT_EMOJI="❓"
DEFAULT_TITLE="Unnamed Script"

# Function to handle cleanup on script interruption or error
cleanup() {
    printf "\n\nScript interrupted. Cleaning up...\n" | tee -a "$LOG_FILE"
    printf "\nFinal Summary (Partial):\n" | tee -a "$LOG_FILE"
    for entry in "${summary[@]}"; do
        printf "%s\n" "$entry" | tee -a "$LOG_FILE"
    done
    printf "\nLogs are stored in %s.\n" "$LOG_FILE_SHORT"
    tput cnorm  # Restore cursor
    exit 1
}

# Trap both SIGINT (Ctrl+C) and any script errors
trap cleanup SIGINT ERR

# Prompt for sudo access at the beginning
prompt_sudo() {
    sudo -v </dev/tty

    # Check if the sudo command succeeded
    if [ $? -ne 0 ]; then
        printf "Sudo authentication failed. Exiting.\n" | tee -a "$LOG_FILE"
        exit 1  # Exit the script entirely
    fi
}

# Function to extract the emoji from the script or return a default one
extract_emoji() {
    local script="$1"
    grep -oP '(?<=# Emoji: ).*' "$script" || echo "$DEFAULT_EMOJI"
}

# Function to extract the title from the script or return a default one
extract_title() {
    local script="$1"
    grep -oP '(?<=# Title: ).*' "$script" || echo "$DEFAULT_TITLE"
}

# Function to run a script and handle its output
run_script() {
    local script="$1"
    local script_name="$(basename "$script" .sh)"
    local emoji="$(extract_emoji "$SCRIPT_DIR/$script")"
    local title="$(extract_title "$SCRIPT_DIR/$script")"
    local tmp_log_file

    # Create a temporary log file to capture output
    tmp_log_file=$(mktemp)

    # Hide cursor to avoid flicker
    tput civis

    # Execute the script, filter out color codes, and capture the output
    bash "$SCRIPT_DIR/$script" 2>&1 | sed -r "s:\x1B\[[0-9;]*[a-zA-Z]::g" > "$tmp_log_file" &
    script_pid=$!

    # Monitor the script's output while it runs
    while kill -0 "$script_pid" 2> /dev/null; do
        tput cup 0 0  # Move cursor to the top-left corner
        tput el  # Clear the entire line

        printf "\nProgress so far:\n"
        for entry in "${summary[@]}"; do
            printf "%s\n" "$entry"
        done
        printf "\n"

        # Ensure the line is completely cleared before printing the new "Running:" message
        printf "\r%-80s" "Running: $title..."
        tput el  # Clear the remainder of the line after printing
        tail -n 10 "$tmp_log_file"  # Show the last 10 lines of the output

        sleep 1
    done

    # Wait for the script to finish
    wait "$script_pid"
    script_status=$?

    # Clear the screen before updating the progress
    tput clear

    # Check the exit status and update the summary
    if [ $script_status -eq 0 ]; then
        summary+=("$emoji $title completed successfully.")
    else
        summary+=("✘ $title failed.")
        printf "Error: %s failed. Stopping further execution.\n" "$title" | tee -a "$LOG_FILE"
        # Append the temporary log to the main log file
        cat "$tmp_log_file" >> "$LOG_FILE"
        rm "$tmp_log_file"
        cleanup
    fi

    # Append the temporary log to the main log file
    cat "$tmp_log_file" >> "$LOG_FILE"
    rm "$tmp_log_file"

    # Display the overall progress
    printf "\nProgress so far:\n"
    for entry in "${summary[@]}"; do
        printf "%s\n" "$entry"
    done
    printf "\nCompleted: %s\n" "$title"

    # Add a small delay to smooth the transition
    sleep 0.25
}

# Prompt for sudo at the beginning of the script
prompt_sudo

# Wait and clear the screen before progressing
sleep 0.25
tput clear

# Iterate over each script in the ordered array and execute it
for script in "${script_order[@]}"; do
    if [[ -f "$SCRIPT_DIR/$script" ]]; then
        run_script "$script"
    else
        printf "Error: %s not found. Stopping execution.\n" "$SCRIPT_DIR/$script" | tee -a "$LOG_FILE"
        cleanup
    fi
done

# Display the final summary
tput clear
printf "\nFinal Summary:\n" | tee -a "$LOG_FILE"
for entry in "${summary[@]}"; do
    printf "%s\n" "$entry" | tee -a "$LOG_FILE"
done

printf "\nLogs are stored in %s.\n" "$LOG_FILE_SHORT"
tput cnorm  # Restore cursor
