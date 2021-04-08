#!/bin/bash
set -e

if ! [ -x "$(command -v docker-compose)" ]; then
    echo "Please install docker: https://docs.docker.com/get-docker/"
    exit 1
fi

docker-compose pull
docker-compose up
