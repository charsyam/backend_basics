#!/bin/bash

REPO_ROOT_PATH=$(git rev-parse --show-toplevel)
$REPO_ROOT_PATH/twemproxy/src/nutcracker -c nutcracker.yml
