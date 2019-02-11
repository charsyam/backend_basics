import kazoo
from kazoo.client import KazooClient

REDIS_NODE_PATH="/backend/caches/redis"

zk = KazooClient(hosts='127.0.0.1:2181')
zk.start()

node_ids = {"000": "127.0.0.1:6379",
            "001": "127.0.0.1:6380",
            "002": "127.0.0.1:6381"}

zk.ensure_path(REDIS_NODE_PATH)
for node_id in node_ids:
    v = REDIS_NODE_PATH + "/" + node_id
    print(v, node_ids[node_id])
    node = zk.exists(v)
    if node:
        print(v, node)
    else:
        zk.create(v, node_ids[node_id].encode('utf-8'))
        print(v, zk.exists(v))
        
