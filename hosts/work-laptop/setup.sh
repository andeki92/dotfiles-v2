#!/usr/bin/env bash


stow tmux zsh git git-wsl

if [ $? -ne 0 ]; then
  echo "Failed to setup symlinks with stow - exit code $?"
  exit 1
fi

script_order=(
    "folder_setup.sh"
    "apt_prerequisites.sh"
    "apt_packages.sh"
    "apt_auto_update.sh"
    "common_zsh_plugins.sh"
    "common_starship_installer.sh"
    "common_bat_theme.sh"
    "common_rust_installer.sh"
    "github_install_asdf.sh"
    "github_install_fzf.sh"
    "github_install_tpm.sh"
    "linux_jetbrains_toolbox.sh"
    "common_gpg_setup.sh"
)

# Source the installer script to run the setup
source "$(dirname "$(realpath "$0")")/../../scripts/common/installer.sh"
