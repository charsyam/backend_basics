#!/bin/bash

REPO_ROOT_PATH=$(git rev-parse --show-toplevel)
sudo cp $REPO_ROOT_PATH/conf/nginx_default_conf /etc/nginx/sites-available/default
sudo /usr/sbin/nginx -s reload
