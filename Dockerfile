FROM alpine:edge
ARG RGA_BINARY=https://github.com/phiresky/ripgrep-all/releases/download/v0.9.6/ripgrep_all-v0.9.6-x86_64-unknown-linux-musl.tar.gz

# this forces alpine/ash to read a user profile file containing the rga-fzf alias
# ENV ENV="/root/.profile"

WORKDIR /app
RUN apk add \
    curl \
    ffmpeg \
    fzf \
    poppler-utils \
    ripgrep && \
    apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/testing pandoc
RUN curl -LO $RGA_BINARY && \
    tar -xvf "$(basename $RGA_BINARY)" && \
    mv ripgrep_all*/rga* /usr/local/bin
COPY rga_fzf /usr/local/bin/
ENTRYPOINT rga_fzf
