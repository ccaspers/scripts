#!/bin/bash
CWD=$(dirname $(readlink -f $0))

# Setup bashscripts
BASHSCRIPTS=$HOME/.bash_customization
touch $HOME/.bashrc
if ! cat $HOME/.bashrc | grep -q ". $BASHSCRIPTS"; then
  ln -s $CWD/bash.sh $BASHSCRIPTS
  echo -e "\n# Sourcing custom modifications \n# Visit https://github.com/ccaspers/scripts for more info\n. $BASHSCRIPTS" >> $HOME/.bashrc
  echo "Scripts added to .bashrc"
else
  echo "Scripts already linked"
fi

# Setup Gitconfig
echo "Please enter your name: "
read -e NAME
echo "Please enter your email: "
read -e EMAIL
echo "Resetting global Git-Config"
rm -f $HOME/.gitconfig
cp gitconfig $HOME/.gitconfig
git config --global user.name "$NAME"
git config --global user.email "$EMAIL"
echo "Done"
