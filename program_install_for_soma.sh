#!/bin/bash

REPO_ROOT_PATH=$(git rev-parse --show-toplevel)

REDIS_VERSION='3.2.8'

if [ ! -d "redis" ]; then
    echo "   3) INSTALLING REDIS-$REDIS_VERSION"
    wget http://download.redis.io/releases/redis-$REDIS_VERSION.tar.gz -P $REPO_ROOT_PATH
    tar zxvf redis-$REDIS_VERSION.tar.gz
    cd redis-$REDIS_VERSION && make
    mv $REPO_ROOT_PATH/redis-$REDIS_VERSION $REPO_ROOT_PATH/redis
    cd ..
else
    echo "   3) INSTALLING REDIS-$REDIS_VERSION (DONE)"
fi

ZOOKEEPER_VERSION='3.4.9'

if [ ! -d "zookeeper" ]; then
    echo "   4) INSTALLING ZOOKEEPER-$ZOOKEEPER_VERSION"
    wget http://mirror.navercorp.com/apache/zookeeper/zookeeper-$ZOOKEEPER_VERSION/zookeeper-$ZOOKEEPER_VERSION.tar.gz -P $REPO_ROOT_PATH
    tar zxvf zookeeper-$ZOOKEEPER_VERSION.tar.gz
    mv $REPO_ROOT_PATH/zookeeper-$ZOOKEEPER_VERSION $REPO_ROOT_PATH/zookeeper
    cp $REPO_ROOT_PATH/conf/zoo.cfg $REPO_ROOT_PATH/zookeeper/conf/zoo.cfg
else
    echo "   4) INSTALLING ZOOKEEPER-$ZOOKEEPER_VERSION (DONE)"
fi
