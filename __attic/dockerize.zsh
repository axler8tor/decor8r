#!/bin/zsh
#set -eu
set now=$(date +%Y%m%d)
set rnd=$(openssl rand -hex 3)
version="0.1.${now}${rnd}"
docker build -t decor8r:${version} .
#docker run --rm --interactive --tty --volume $PWD:/test decor8r:${version} "$@"
