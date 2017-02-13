#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  CWD=$(dirname $(readlink -f $0))
  initfile=$HOME/.bashrc
elif [[ "$OSTYPE" == "darwin"* ]]; then
  CWD=$(dirname $(greadlink -f $0))
  initfile=$HOME/.profile
else
  echo "$OSTYPE is currently not supported"
  exit 1
fi

# --------------------------------------------------------------
# BASHCONFIG : Setup usual aliases
# --------------------------------------------------------------
bash_config=$CWD/bash.sh
touch $initfile
marker_start="# CC:DOTFILES:START"
marker_end="# CC:DOTFILES:END"
sed -i.backup "/$marker_start/,/$marker_end/d" $initfile 

bash_import="\n$marker_start 
# Sourcing personal configuration
# Visit https://github.com/ccaspers/scripts for more info
source $bash_config
$marker_end"

# rewrite initfile to fix multiple blank lines
init_text=$(cat $initfile)
( echo "$init_text" ; echo -e "$bash_import" ; ) | uniq > $initfile


# --------------------------------------------------------------
# DOTFILES : link dotfiles as hidden files to Home-Directory 
# --------------------------------------------------------------
echo ">> setting symlinks for dotfiles"
for file in $CWD/dotfiles/*
do
  name=$(basename $file)
  link="$HOME/.$name"
  if [ ! -e $link ]; then
    echo " >> linking $link to $file"
    ln -s $file $link
  fi
done

# --------------------------------------------------------------
# COMMANDS : link commands to ~/.local/bin
# --------------------------------------------------------------
mkdir -p $HOME/.local/bin 

echo ">> setting symlinks for custom commands"
for cmd in $CWD/bin/*
do
  name=$(basename $cmd)
  link=$HOME/.local/bin/$name
  if [ ! -e $link ]; then
    echo " >> linking $link to $cmd"
    ln -s $cmd $link
  fi
done

# --------------------------------------------------------------
# GITCONFIG : link .gitconfig and os-specific configuration
# linux-config is considered default
# --------------------------------------------------------------
git_config="$CWD/gitconfig/gitconfig"
git_config_os="$git_config.linux"
link="$HOME/.gitconfig"
link_os="$link.os"

if [[ "$OSTYPE" == "darwin"* ]]; then
  git_config_os="$git_config.macos"
fi

rm -f $link_os
ln -s $git_config_os $HOME/.gitconfig.os
rm -f $link
ln -s $git_config $HOME/.gitconfig

