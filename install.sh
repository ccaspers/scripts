#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  CWD=$(dirname $(readlink -f $0))
  INITFILE=$HOME/.bashrc
elif [[ "$OSTYPE" == "darwin"* ]]; then
  CWD=$(dirname $(greadlink -f $0))
  INITFILE=$HOME/.profile
else
  echo "$OSTYPE is currently not supported"
  exit 1
fi

BASHSCRIPTS=$CWD/bash.sh

touch $INITFILE
if ! cat $INITFILE | grep -q "$BASHSCRIPTS"; then
  # Don't replace tabs with spaces in here-doc
  cat <<-EOS >> $INITFILE

	# Sourcing personal configuration
	# Visit https://github.com/ccaspers/scripts for more info
	source $BASHSCRIPTS
	EOS
  echo ">> Scripts added to $INITFILE"
else
  echo ">> Scripts already linked"
fi

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

# link commands to ~/.local/bin
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
