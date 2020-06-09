PROMPT='%B%F{33}SI%f %* %(?.%F{green}$.%F{red}$ %?)%f %B%F{240}%1~%f%b %# '

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{240}(%b)%r%f'
zstyle ':vcs_info:*' enable git

alias dps="docker ps"

alias k="kubectl"
alias kd="kubectl get deployments"
alias ks="kubectl get services"
