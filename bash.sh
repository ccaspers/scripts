#aliases
unalias git > /dev/null 2>&1
unalias g > /dev/null 2>&1
unalias nano > /dev/null 2>&1
alias g='git'
alias nano='nano -c -T4'
alias pico='nano'
alias n='nano'

#prompt
LINE1="\n\[\e[32;1m\](\[\e[37;1m\]\u\[\e[32;1m\])-(\[\e[37;1m\]jobs:\j\[\e[32;1m\])-(\[\e[37;1m\]\w\[\e[32;1m\])"
LINE2="\n(\[\e[37;1m\]! \!\[\e[32;1m\])-> \[\e[0m\]"
PS1=$LINE1$LINE2
