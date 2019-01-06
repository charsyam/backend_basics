#!/bin/bash
FLASK_APP=app$1.py flask run --host=0.0.0.0 --port=$2
