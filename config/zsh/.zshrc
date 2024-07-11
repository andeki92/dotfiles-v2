#!/usr/bin/env zsh

if [ "$TMUX" = "" ]; then tmux; fi

# .zshenv is loaded before anything happens here!
[ -f ~/.zshenv ] && source ~/.zshenv

# Functions
[ -f ~/.config/zsh/functions.zsh ] && source ~/.config/zsh/functions.zsh

# Aliases
[ -f ~/.config/zsh/aliases.zsh ] && source ~/.config/zsh/aliases.zsh

# Aliases v2
[ -f ~/.config/zsh/alias.zsh ] && source ~/.config/zsh/alias.zsh

# Source starship environment if it exists
[ -f ~/.config/zsh/starship.zsh ] && source ~/.config/zsh/starship.zsh

# Source wsl environment if it exists
[ -f ~/.config/zsh/wsl.zsh ] && source ~/.config/zsh/wsl.zsh

# Source mac environment if it exists
[ -f ~/.config/zsh/mac.zsh ] && source ~/.config/zsh/mac.zsh

# Source rust environment if it exists
[ -f ~/.cargo/env ] && source ~/.cargo/env

# Install starship if it doesn't exist
if ! command_exists starship; then
    echo "❌ starship is not installed"
    exit 1
fi

# Source the starship initialization script
eval "$(starship init zsh)"

# autoload -Uz compinit bashcompinit && compinit && bashcompinit
autoload -Uz compinit && compinit

# Source kubectl completion
command -v kubectl >/dev/null 2>&1 && source ~/.config/zsh/autocomplete/kubectl

# # ASDF
[ -f "$(brew --prefix asdf)/libexec/asdf.sh" ] && source "$(brew --prefix asdf)/libexec/asdf.sh"
