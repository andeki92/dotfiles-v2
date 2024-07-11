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

# --- starship ---

# Check that the function `starship_zle-keymap-select()` is defined.
# xref: https://github.com/starship/starship/issues/3418
type starship_zle-keymap-select >/dev/null ||
    {
        echo "Loading starship"
        eval "$(starship init zsh)"
    }

# --- fzf ---
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_OPTS=" \
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
--color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

_fzf_compgen_path() {
    fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
    fd --hidden --exclude .git . "$1"
}

# autoload -Uz compinit bashcompinit && compinit && bashcompinit
autoload -Uz compinit && compinit

# Source kubectl completion
command -v kubectl >/dev/null 2>&1 && source ~/.config/zsh/autocomplete/kubectl

# # ASDF
[ -f "$(brew --prefix asdf)/libexec/asdf.sh" ] && source "$(brew --prefix asdf)/libexec/asdf.sh"
