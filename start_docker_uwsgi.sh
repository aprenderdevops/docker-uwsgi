#!/bin/bash
if [ $# -eq 0 ]; then
    echo "Uso: $0 PUERTO"
    exit 1
fi
PUERTO=$1
docker run -d -p $PUERTO:$PUERTO --restart unless-stopped -v $(pwd)/WebApp:/WebApp -e UWSGI_HTTP_PORT=$PUERTO -e UWSGI_APP=webapp aprenderdevops/uwsgi
