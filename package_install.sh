#!/bin/bash

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y build-essential libtool autoconf
sudo apt-get install -y git
sudo apt-get install -y zlib1g-dev libssl-dev libbz2-dev
sudo apt-get install -y libsasl2-dev libxml2-dev libsqlite3-dev
sudo apt-get install -y libxslt1-dev python-dev python3-dev
sudo apt-get install -y libreadline-dev
sudo apt-get install -y mysql-server
sudo apt-get install -y nginx

sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer
