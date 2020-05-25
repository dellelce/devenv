
# Base image alpine:latest
FROM alpine:latest

LABEL maintainer="Antonio Dell'Elce"

ARG id=jdk8
ARG port=8080

ENV APP  /app/${id}
ENV HOME /root

ENV TZ   "Europe/London"

COPY vimrc   ${HOME}/.vimrc
COPY profile ${HOME}/.bashrc

# Packages
RUN apk add bash vim wget gawk openssh-client   \
            git libc-dev make                   \
            linux-headers                       \
            openjdk8 maven gradle              \
            bind-tools file xz tzdata

WORKDIR /work
ENTRYPOINT ["/bin/bash"]

## EOF ##
