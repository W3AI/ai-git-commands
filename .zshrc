PROMPT='%B%F{33}SI%f %* %(?.%F{green}$.%F{red}$ %?)%f %B%F{240}%1~%f%b %# '

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{240}(%b)%r%f'
zstyle ':vcs_info:*' enable git

alias cl="clear"

alias python="python3"
alias p3="python3"

alias dps="docker ps"

alias dra="deno run --allow-all"

alias k="kubectl"
alias kd="kubectl get deployments"
alias ks="kubectl get services"

# make a directory and cd to it
md()
{
    test -d "$1" || mkdir "$1" && cd "$1"
}

# make a file and open it in VS Code
mf()
{
    touch "$1" && code "$1"
}

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/stefanianta/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/stefanianta/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/stefanianta/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/stefanianta/google-cloud-sdk/completion.zsh.inc'; fi
