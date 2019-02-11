from flask import Flask
import redis
import kazoo

app = Flask(__name__)

from kazoo.client import KazooClient
import logging

zk = KazooClient(hosts='127.0.0.1:2181')
zk.start()

REDIS_NODE_PATH="/backend/caches/redis"
redis_conns = []

def create_redis_connections():
    # TODO
    # Implement code to get redis lists from Zookeeper
    raise Exception("Not Implements")

create_redis_connections()

def get_index(name):
    s = 0
    for i in name:
        s += ord(i)

    return s % len(redis_conns)
    
@app.route('/<name>')
def hello_world(name):
    idx = get_index(name)
    rconn = redis_conns[idx]
    v = rconn.incr(name)
    return "Hello, {name}!, visit count = {count}".format(name=name, count=v)

@app.route('/lists')
def lists():
    v = [conn.connection_pool.get_connection("").port for conn in redis_conns]
    return str(v)
