import json
import redis
import arrow

from flask import Flask
from flask import Response
from flask import jsonify
from flask import request
app = Flask(__name__)

API_5M_MAXIMUM_NUMBER = 10

rconn = redis.StrictRedis()

def key_gen(prefix, minus_minutes):
    return "{prefix}:{time}".format(prefix=prefix, time=arrow.utcnow().shift(minutes=-minus_minutes).strftime("%H%M"))

def get_api_count(token):
    pass

def update_count(token):
    pass

def is_valid_user(token):
    pass

def get_response_by_count(token, count, maximum_count):
    msg = ""
    status = 200

    if count < maximum_count:
        msg = "Hello World!(Left: {count})".format(count=maximum_count-count)
    else:
        msg = "Call limit exceeded error"
        status = 429

    data = {"response": {"msg": msg}}
    return data, status

@app.route('/api/hello')
def hello():
    access_token = request.args.get('access_token')
    if not access_token:
        data = {"response": {"msg": "no token param"}}
        return Response(response=json.dumps(data),
                        status=401,       
                        mimetype='application/json')

    access_token = access_token.encode('utf-8')
    if not is_valid_user(access_token):
        data = {"response": {"msg": "invalid user {token}".format(token=access_token)}}
        return Response(response=json.dumps(data),
                        status=401,       
                        mimetype='application/json')
        
    try:
        count = get_api_count(access_token)
        msg, status = get_response_by_count(access_token, count, API_5M_MAXIMUM_NUMBER)
    except Exception as e:
        msg = str(e)
        status = 501
        return Response(response=json.dumps(msg),
                    status=status,
                    mimetype='application/json')

    if status == 200:
        update_count(access_token)

    return Response(response=json.dumps(msg),
                    status=status,
                    mimetype='application/json')

if __name__ == '__main__':
    app.run(debug=True)
