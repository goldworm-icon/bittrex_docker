FROM python:3.7-slim

MAINTAINER mycom22 <mycom22@iconloop.com>

ARG VERSION
ARG CONTAINER
ARG HOST_ROOT_DIR
ARG DOCKER_PORT

ADD ${CONTAINER} /work
RUN apt-get update && \
    apt-get install -y git libleveldb1d libleveldb-dev g++

WORKDIR /src
RUN git clone https://github.com/leeheonseung/bittrex_${CONTAINER}_server.git /src && \
	./build.sh && \
	pip install dist/${CONTAINER}server*.whl

EXPOSE ${DOCKER_PORT}

WORKDIR /work


HEALTHCHECK --interval=5s --timeout=3s --retries=3 \
      CMD curl -f https://localhost:${DOCKER_PORT} || exit 1

RUN chmod 755 ./entrypoint.sh
ENTRYPOINT [ "./entrypoint.sh" ]