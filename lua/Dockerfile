FROM alpine:3.8

LABEL maintainer="Antonio Dell'Elce"

ARG id=devenv
ARG port=8080

ENV APP  /app/${id}
ENV HOME /root

ENV TZ   "Europe/London"

COPY ${id}   ${HOME}
COPY vimrc   ${HOME}/.vimrc
COPY profile ${HOME}/.bashrc

# Packages
RUN apk add bash vim wget gawk openssh-client   \
            gcc git libc-dev make               \
            cmake bison                         \
            perl                                \
            linux-headers                       \
            lua5.3-dev                          \
            bind-tools file xz tzdata

# Some symlinks
RUN ln -s /usr/bin/lua5.3 /usr/bin/lua && \
    ln -s /usr/bin/luac5.3 /usr/bin/luac

# install mkit
RUN v=master; cd && wget -O mkit.tar.gz -q "https://github.com/dellelce/mkit/archive/${v}.tar.gz" && \
    tar xf mkit.tar.gz && mv mkit-* mkit && ln -s ../mkit/mkit.sh bin && rm mkit.tar.gz

ENV PATH "${HOME}/mkit:${PATH}"

WORKDIR /work
ENTRYPOINT ["/bin/bash"]

## EOF ##
