#!/bin/bash

REPO_ROOT_PATH=$(git rev-parse --show-toplevel)
$REPO_ROOT_PATH/redis/src/redis-server ./6379.conf
$REPO_ROOT_PATH/redis/src/redis-server ./6380.conf
$REPO_ROOT_PATH/redis/src/redis-server ./6381.conf
