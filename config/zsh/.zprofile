# Explanation of what this files does and when it is loaded
# https://apple.stackexchange.com/questions/388622/zsh-zprofile-zshrc-zlogin-what-goes-where

# XDG
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

# ## History command configuration
# HISTSIZE=5000                 # How many lines of history to keep in memory
# HISTFILE=~/.zsh_history       # Where to save history to disk
# SAVEHIST=5000                 # Number of history entries to save to disk
# setopt extended_history       # record timestamp of command in HISTFILE
# setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
# setopt hist_ignore_dups       # ignore duplicated commands history list
# setopt hist_ignore_space      # ignore commands that start with space
# setopt hist_verify            # show command with history expansion to user before running it
# setopt inc_append_history     # add commands to HISTFILE in order of execution
# setopt share_history          # share command history data

# Brew
if [ -d "${brew_home}" ]; then
    export PATH=${brew_home}/bin:$PATH
fi
