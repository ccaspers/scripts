#!/bin/bash
# Downloads setup-tools and installs them to the current
# home-directory, then pip, virtualenv, virtualenvwrapper
# and nodeenv will be installed
BASHRC=$HOME/.bashrc

echo "### automatic setup for local python and pip starts here###" >> $BASHRC
# Setup initial config
echo "export PATH=\$PATH:$HOME/.local/bin" >> $BASHRC
source $BASHRC
wget https://bootstrap.pypa.io/ez_setup.py -O - | python - --user
# Install pip and virtualenv
source $BASHRC
easy_install pip
pip install --user virtualenv
pip install --user virtualenvwrapper
pip install --user nodeenv
# add virtualenv to PATH
mkdir -p $HOME/.virtualenvs
echo "export WORKON_HOME=$HOME/.virtualenvs" >> $BASHRC
echo "source $HOME/.local/bin/virtualenvwrapper.sh" >> $BASHRC
echo "### automatic setup for local python and pip ends here###" >> $BASHRC
source $BASHRC
