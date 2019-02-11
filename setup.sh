#!/bin/bash

REPO_ROOT_PATH=$(git rev-parse --show-toplevel)

PYTHON_VERSION="3.5.2"
PYENV_DIR=~/.pyenv
AUTOENV_DIR=~/.autoenv

install_python_version=$(pyenv versions | grep $PYTHON_VERSION)
if [ -z "$install_python_version" ]; then
    echo "   1-1) INSTALLING PYTHON $PYTHON_VERSION"
    pyenv install $PYTHON_VERSION
    pyenv shell $PYTHON_VERSION
    easy_install -U setuptools
    pip install virtualenv
else
    echo "   1-1) INSTALLING PYTHON $PYTHON_VERSION (DONE)"
fi

installenv=$(pyenv versions | grep backend-env)
if [ -z "$installenv" ]; then
    echo "   1-2) INSTALLING VIRTUALENV backend-env"
    pyenv virtualenv $PYTHON_VERSION backend-env;
else
    echo "   1-2) INSTALLING VIRTUALENV backend-env (DONE)"
fi

env_dir=$REPO_ROOT_PATH/env
pip_hash_path=$env_dir/requirements.hash
if [ ! -f $pip_hash_path ]; then
    echo "   2) Update python dependecies"
    pip install -r $REPO_ROOT_PATH/requirements.txt --upgrade
    latest_hash=$(git hash-object $REPO_ROOT_PATH/requirements.txt)
    mkdir -p $env_dir && echo $latest_hash > $pip_hash_path
else
    hash=$(cat $pip_hash_path)
    latest_hash=$(git hash-object $REPO_ROOT_PATH/requirements.txt)
    if [ ! $hash = $latest_hash ]; then
        echo "   2) Update python dependecies"
        pip install -r $REPO_ROOT_PATH/requirements.txt --upgrade
        mkdir -p $env_dir && echo $latest_hash > $pip_hash_path
    else
        echo "   2) Update python dependecies (DONE)"
    fi
fi
