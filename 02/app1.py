from flask import Flask
import redis

app = Flask(__name__)

r1 = redis.StrictRedis(host='localhost', port=6379, db=0)
r2 = redis.StrictRedis(host='localhost', port=6380, db=0)
r3 = redis.StrictRedis(host='localhost', port=6381, db=0)

conns = [r1, r2, r3]

def get_index(name):
    #TODO
    #implement modula sharding with sizeof conns
    raise Exception("Not Implements")

@app.route('/<name>')
def hello_world(name):
    idx = get_index(name)
    rconn = conns[idx]
    v = rconn.incr(name)
    return "Hello, {name}!, visit count = {count}".format(name=name, count=v)
