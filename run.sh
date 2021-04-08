#!/bin/bash
set -e

if ! [ -x "$(command -v docker-compose)" ]; then
    echo "Please install docker and docker-compose: https://docs.docker.com/get-docker/"
    exit 1
fi

docker-compose pull || ( echo -e "\n\n\nTry running ./run.sh with sudo" && exit 1 )
docker-compose up
