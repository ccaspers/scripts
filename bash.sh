DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#aliases
unalias git > /dev/null 2>&1
unalias g > /dev/null 2>&1
unalias nano > /dev/null 2>&1
alias g='git'
alias nano='nano -c -T4'
alias pico='nano'
alias n='nano'
alias agu='sudo apt-get update && sudo apt-get upgrade'
alias agi='sudo apt-get install'
alias ls='ls --sort=extension --group-directories-first --color=auto -h'

unalias l > /dev/null 2>&1
unalias la > /dev/null 2>&1
unalias ll > /dev/null 2>&1
alias l='ls'
alias la='ls -a'
alias ll='ls -l'

# emulates osx's open-command on linux
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  open() { fork xdg-open "$@"; }
    export -f open
fi
    
# fix open from tmux on osx
if command -v reattach-to-user-namespace >/dev/null 2>&1; then
    alias subl='reattach-to-user-namespace subl'
    alias stree='reattach-to-user-namespace stree'
    alias open='reattach-to-user-namespace open'
fi

#prompt
LINE1="\n\[\e[32;1m\](\[\e[37;1m\]\u\[\e[32;1m\])-(\[\e[37;1m\]jobs:\j\[\e[32;1m\])-(\[\e[37;1m\]\w\[\e[32;1m\])\n"
LINE2="\[\e[32;1m\](\[\e[37;1m\]! \!\[\e[32;1m\])-> \[\e[0m\]"
PS1=$LINE1$LINE2

#add .local/bin to path
export PATH=$PATH:~/.local/bin

# grep
alias grep='grep --color=auto'
export GREP_COLOR='1;35;40'

# fork-function to detach processes from shell conveniently
fork() { (setsid "$@" &>/dev/null); }
export -f fork
