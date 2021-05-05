#!/bin/bash

DOCKER_COMPOSE_FILENAME=docker-compose.dev.yml

set -e

RUN_ROOT="$(dirname "$0")"

pushd $RUN_ROOT

if ! [ -x "$(command -v docker-compose)" ]; then
    echo "Please install docker and docker-compose: https://docs.docker.com/get-docker/"
    exit 1
fi

docker-compose -f ${DOCKER_COMPOSE_FILENAME} pull || ( echo -e "\n\n\nTry running ./run.sh with sudo" && exit 1 )
docker-compose -f ${DOCKER_COMPOSE_FILENAME} up "$@"

popd
