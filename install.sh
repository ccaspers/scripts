#!/bin/bash
CWD=$(dirname $(readlink -f $0))

# Setup bashscripts
BASHSCRIPTS=$CWD/bash.sh
BASHRC=$HOME/.bashrc

touch $BASHRC
if ! cat $BASHRC | grep -q "$BASHSCRIPTS"; then
  # Don't replace tabs with spaces in here-doc
  cat <<-EOS >> $BASHRC
	
	# Sourcing custom modifications
	# Visit https://github.com/ccaspers/scripts for more info
	source $BASHSCRIPTS
	EOS
  echo ">> Scripts added to .bashrc"
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
