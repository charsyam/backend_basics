#!/bin/bash

REPO_ROOT_PATH=$(git rev-parse --show-toplevel)

REDIS_VERSION='5.0.5'

if [ ! -d "redis" ]; then
    echo "   3) INSTALLING REDIS-$REDIS_VERSION"
    wget http://download.redis.io/releases/redis-$REDIS_VERSION.tar.gz -P $REPO_ROOT_PATH
    tar zxvf redis-$REDIS_VERSION.tar.gz
    cd redis-$REDIS_VERSION && make
    ln -sf $REPO_ROOT_PATH/redis-$REDIS_VERSION $REPO_ROOT_PATH/redis
    cd $REPO_ROOT_PATH
else
    echo "   3) INSTALLING REDIS-$REDIS_VERSION (DONE)"
fi

if [ ! -d "twemproxy" ]; then
    echo "   3) INSTALLING twemproxy-latest"
    git clone https://github.com/twitter/twemproxy
    cd twemproxy && autoreconf -fvi && ./configure --enable-debug=full && make
    ln -sf $REPO_ROOT_PATH/twemproxy/src/nutcracker $REPO_ROOT_PATH/nutcracker
    cd $REPO_ROOT_PATH
else
    echo "   3) INSTALLING TWEMPROXY-LATEST (DONE)"
fi

ZOOKEEPER_VERSION='3.5.5'

if [ ! -d "zookeeper" ]; then
    echo "   4) INSTALLING ZOOKEEPER-$ZOOKEEPER_VERSION"
    ZOO_FOLDER=apache-zookeeper-$ZOOKEEPER_VERSION-bin
    ZOO_FILENAME=$ZOO_FOLDER.tar.gz
    wget http://mirror.navercorp.com/apache/zookeeper/zookeeper-$ZOOKEEPER_VERSION/$ZOO_FILENAME -P $REPO_ROOT_PATH
    tar zxvf $ZOO_FILENAME
    ln -sf $REPO_ROOT_PATH/$ZOO_FOLDER $REPO_ROOT_PATH/zookeeper
    cp $REPO_ROOT_PATH/conf/zoo.cfg $REPO_ROOT_PATH/zookeeper/conf/zoo.cfg
else
    echo "   4) INSTALLING ZOOKEEPER-$ZOOKEEPER_VERSION (DONE)"
fi
