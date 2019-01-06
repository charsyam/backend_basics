from flask import Flask
import redis
import kazoo
from ch import ConsistentHash

app = Flask(__name__)

from kazoo.client import KazooClient
import logging

zk = KazooClient(hosts='127.0.0.1:2181')
zk.start()
logger = logging.getLogger('tcpserver')

REDIS_NODE_PATH="/soma/caches/redis"
redis_ch = None

def rebuild_redis_connections(children):
    global redis_ch
    kvlist = []
    for child in children:
        try:
            value = zk.get(REDIS_NODE_PATH + "/" + child)[0].decode("utf-8")
            v = value.split(':')
            r = redis.StrictRedis(v[0], v[1])
            kvlist.append((value, r))
        except:
            print(child)

    replica = 2
    redis_ch = ConsistentHash(kvlist, replica)
    redis_ch.get('charsyam')

def redis_watch_func(children):
    create_redis_connections()
    watch_redis_node()

def watch_redis_node():
    children = zk.get_children(REDIS_NODE_PATH, watch=redis_watch_func)

def create_redis_connections():
    children = zk.get_children(REDIS_NODE_PATH)
    rebuild_redis_connections(children)
    watch_redis_node()

create_redis_connections()

@app.route('/<name>')
def hello_world(name):
    v = redis_ch.get(name)
    rconn = v[1]
    v = rconn.incr(name)
    return "Hello, {name}!, visit count = {count}".format(name=name, count=v)

@app.route('/lists')
def lists():
    return str(redis_ch.kvlist)
