#!/usr/bin/env bash

set -eu

BAT_CONFIG="$(bat --config-dir)/config"
THEME_SETTING='--theme="Catppuccin Macchiato"'

if [ ! -f "$BAT_CONFIG" ]; then
    mkdir -p "$(dirname "$BAT_CONFIG")"   # Create the directory if it doesn't exist
    touch "$BAT_CONFIG"                   # Create the file
    mkdir -p "$(bat --config-dir)/themes" # Create the themes directory
fi

if [ -z "$(bat --list-themes | grep 'Macchiato')" ]; then
    wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Macchiato.tmTheme
    bat cache --build
fi

# Check if the config file contains any --theme setting
if grep -q -- '--theme' "$BAT_CONFIG"; then
    # --theme setting exists, replace it with the new theme
    sed -i 's/--theme=.*/'"$THEME_SETTING"'/' "$BAT_CONFIG"
else
    # --theme setting does not exist, add the new theme
    echo "$THEME_SETTING" >>"$BAT_CONFIG"
fi
