################################################################################
## Basic Shell Config
################################################################################
# Source the locale
source $HOME/.locale
export EDITOR=nano

# Lines configured by zsh-newuser-install
HISTFILE=$HOME/.histfile
HISTSIZE=10000000
SAVEHIST=10000000
setopt histignorespace

# enable antigen
source /usr/share/zsh/share/antigen.zsh
antigen init $HOME/.antigenrc


################################################################################
## Software
################################################################################
# node version manager
export NVM_DIR="${XDG_CONFIG_HOME:-$HOME/.}nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use

# PHP Composer Globals
PATH="$HOME/.config/composer/vendor/bin:$PATH"

# add .local/bin
export PATH="$HOME/.local/bin:$PATH"


################################################################################
## Aliases and Functions
################################################################################
# ls
alias ls='ls --color=auto'
alias la='ls -la'

# open files from terminal
alias open="xdg-open 2>/dev/null"

# cleanup python files
pyclean () {
    find . -type f -name "*.py[co]" -delete
    find . -type d -name "__pycache__" -delete
}

# make aliases work with sudo
alias sudo="sudo "

# serve static files

serve () {
    python3 -m http.server 8000
}

################################################################################
## Keybyindings
################################################################################
bindkey '^ ' autosuggest-accept
