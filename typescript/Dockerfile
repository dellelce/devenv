# Base image: standard alpine 3.11
FROM alpine:3.11

LABEL maintainer="Antonio Dell'Elce"

ARG id=ts
ARG port=8080

ENV APP  /app/${id}
ENV HOME /root

ENV TZ   "Europe/London"

COPY vimrc   ${HOME}/.vimrc
COPY profile ${HOME}/.bashrc

COPY tsenv   /work

# Packages
RUN apk add bash vim wget gawk openssh-client   \
            nodejs npm                          \
            bind-tools file xz tzdata

# Typescript
RUN   npm install --silent --save-dev -g \
        typescript

WORKDIR /work
ENTRYPOINT ["/bin/bash"]

## EOF ##
