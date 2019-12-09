#!/bin/zsh
#set -eu
docker build -t decor8r .
#docker run --rm --interactive --tty --volume $PWD:/test decor8r "$@"
