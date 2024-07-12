#!/usr/bin/env bash

function get_source_list() {
    local session_list
    mapfile -t session_list < <(tmux list-sessions -F "#S" 2>/dev/null)

    local candidate_list
    local session_name
    mapfile -t candidate_list < <(find ~/workspace -mindepth 1 -maxdepth 1 -type d | sort)
    candidate_list+=("main_session")
    for repo in "${candidate_list[@]}"; do
        session_name=$(basename "$repo" | sed 's/\./_/g')
        printf "$repo\n"
    done
}

function get_selected_source() {
    get_source_list | fzf --height 100% | tr -d '\n'
}

function set_session() {
    local selected_source
    selected_source="$(get_selected_source)"

    if [ -z "$selected_source" ]; then
        return
    fi

    local repo_dir

    if [ "$selected_source" == "main_session" ]; then
        repo_dir=$HOME
    else
        repo_dir="$selected_source"
    fi

    local session_name
    session_name=$(basename "$selected_source" | sed 's/\./_/g')

    if [[ -z "$TMUX" ]]; then
        tmux new-session -A -s "$session_name" -c "$repo_dir" 2>/dev/null
    elif [ "$(tmux display-message -p "#S")" != "$session_name" ]; then
        tmux new-session -d -s "$session_name" -c "$repo_dir" 2>/dev/null
        tmux switch-client -t "$session_name"
    fi
}

set_session
