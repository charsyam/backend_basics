#!/bin/bash

echo 'export LANGUAGE=en_US.UTF-8' >> ~/.bashrc
echo 'export LC_ALL=en_US.UTF-8' >> ~/.bashrc
sudo locale-gen en_US.UTF-8

echo "===================================================="
echo "RUN source ~/.bashrc"
echo "RUN ./package_install.sh"
echo "===================================================="

echo
echo "thank you very much"
echo
