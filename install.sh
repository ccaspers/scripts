#!/bin/bash
CWD=$(dirname $(readlink -f $0))

# Setup bashscripts
BASHSCRIPTS=$HOME/.bash_customization
touch $HOME/.bashrc
if ! cat $HOME/.bashrc | grep -q ". $BASHSCRIPTS"; then
  ln -s $CWD/bash.sh $BASHSCRIPTS
  echo -e "\n# Sourcing custom modifications \n# Visit https://github.com/ccaspers/scripts for more info\n. $BASHSCRIPTS" >> $HOME/.bashrc
  echo " >> Scripts added to .bashrc"
else
  echo " >> Scripts already linked"
fi

# Setup symlinks for dotfiles
for file in $CWD/dotfiles/*
do
	name=$(basename $file)
	link="$HOME/.$name"
	echo " >> linking $link to $file"
	rm -f $link
	ln -s $file $link
done
