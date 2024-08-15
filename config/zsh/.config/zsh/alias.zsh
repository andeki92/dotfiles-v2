alias cat="bat"
alias fd="fdfind"

# --- eza 📃 (https://github.com/eza-community/eza) ---
alias ls='eza --color=always --group-directories-first --icons'
alias ll='eza -la --icons --octal-permissions --group-directories-first'
alias l='eza --tree --level=2 --color=always --group-directories-first --icons'
alias la='eza --long --all --group --group-directories-first'
alias lx='eza -lbhHigUmuSa@ --time-style=long-iso --git --color-scale --color=always --group-directories-first --icons'
alias l.="eza -a | grep -E '^\.'" # show dot-prefixed files

# -- kubectl 🚢 (https://kubernetes.io/docs/reference/kubectl/)
alias k="kubectl"

alias kxsh="kubectl_exec_sh"
alias kxbash="kubectl_exec_bash"

alias rgf='rg --files | rg'

alias tb="jetbrains-toolbox"
