#!/bin/bash

PYENV_DIR=~/.pyenv
AUTOENV_DIR=~/.autoenv

if [ ! -d $PYENV_DIR ]; then
    git clone https://github.com/yyuu/pyenv.git $PYENV_DIR
    git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(pyenv init -)"' >> ~/.bashrc
    echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc
fi

if [ ! -d $AUTOENV_DIR ]; then
    git clone https://github.com/kennethreitz/autoenv.git ~/.autoenv
    echo 'source ~/.autoenv/activate.sh' >> ~/.bashrc
fi

echo "===================================================="
echo "run source ~/.bashrc"
echo "run setup.sh"
echo "===================================================="

. ~/.bashrc

