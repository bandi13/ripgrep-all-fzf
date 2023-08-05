FROM alpine:edge

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

ARG RGA_VERSION=v1.0.0-alpha.5
RUN curl -s -o - -L https://github.com/phiresky/ripgrep-all/releases/download/${RGA_VERSION}/ripgrep_all-${RGA_VERSION}-x86_64-unknown-linux-musl.tar.gz | \
    tar -xzf - && \
    mv ripgrep_all*/rga* /usr/local/bin && \
    rm -rf ripgrep_all*
COPY rga_fzf /usr/local/bin/
ENTRYPOINT rga_fzf
