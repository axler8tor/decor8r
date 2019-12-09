FROM alpine:3.10

MAINTAINER github.com/axler8r/decor8r

USER root
RUN apk add --no-cache --update \
    zsh \
    tmux \
    neovim \
    git \
    && \
    rm -rf /var/cache/apk/*
RUN git config --global user.email "decor8r@axler8r.io" \
    && \
    git config --global user.name  "decor8r"

ENV USER root

ENTRYPOINT [ "/bin/zsh" ]
