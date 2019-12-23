#!/bin/bash

VERSION=v0.0.1
CONTAINER=node

HOST_PORT=9001
HOST_ROOT_DIR=$(pwd)/${CONTAINER}

DOCKER_PORT=9000

echo ${VERSION}
echo ${HOST_ROOT_DIR}

docker build \
	--force-rm=true \
	--rm=true \
	--tag ${CONTAINER}:${VERSION} \
	--build-arg VERSION=${VERSION} \
	--build-arg CONTAINER=${CONTAINER} \
	--build-arg HOST_ROOT_DIR=${HOST_ROOT_DIR} \
	--build-arg DOCKER_PORT=${DOCKER_PORT} \
	.

docker run \
	--rm \
	-d \
	--name ${CONTAINER} \
	-p ${HOST_PORT}:${DOCKER_PORT} \
	-v ${HOST_ROOT_DIR}:/work \
	${CONTAINER}:${VERSION}