alias fd="fdfind"

# --- eza 📃 (https://github.com/eza-community/eza) ---
alias ls='eza --color=always --group-directories-first --icons'
alias ll='eza -la --icons --octal-permissions --group-directories-first'
alias l='eza --tree --level=2 --color=always --group-directories-first --icons'
alias la='eza --long --all --group --group-directories-first'
alias lx='eza -lbhHigUmuSa@ --time-style=long-iso --git --color-scale --color=always --group-directories-first --icons'
alias l.="eza -a | grep -E '^\.'" # show dot-prefixed files

# -- kubectl 🚢 (https://kubernetes.io/docs/reference/kubectl/)
# kubernetes aliases
alias k="kubectl"

alias kg="k get"
alias kgp="kg pods"
alias kgs="kg svc"

alias kd="k describe"
alias kdp="kd pods"
alias kds="kd service"

alias kpf="k port-forward"
alias kl="k logs"

# kubernetes plugin shortcuts
alias kx="k ctx"
alias kn="k ns"

# kubectl function aliases
alias kex="kubectl_exec_into_pod"
alias kps="kubectl_psql_start"


alias rgf='rg --files | rg'

alias gd="cd ~/.dotfiles"
alias gw="cd ~/workspace"
alias gp="cd ~/privatespace"

alias rl="source ~/.zshrc && clear"

# on ubuntu/debian bat is installed as batcat
type batcat >/dev/null 2>&1 && alias bat="batcat"
alias cat="bat"
