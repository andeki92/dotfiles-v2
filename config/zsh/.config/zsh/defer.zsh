#!/usr/bin/env zsh

# Functions
[ -f ~/.config/zsh/functions.zsh ] && source ~/.config/zsh/functions.zsh

# Aliases
[ -f ~/.config/zsh/aliases.zsh ] && source ~/.config/zsh/aliases.zsh

# Functions v2
[ -f ~/.config/zsh/function.zsh ] && source ~/.config/zsh/function.zsh

# Aliases v2
[ -f ~/.config/zsh/alias.zsh ] && source ~/.config/zsh/alias.zsh

# Source starship environment if it exists
[ -f ~/.config/zsh/starship.zsh ] && source ~/.config/zsh/starship.zsh
