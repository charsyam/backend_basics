#!/bin/bash

REPO_ROOT_PATH=$(git rev-parse --show-toplevel)
$REPO_ROOT_PATH/zookeeper/bin/zkServer.sh $1
