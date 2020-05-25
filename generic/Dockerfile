# Docker image used to test/develop inside my standard docker environment
FROM dellelce/cairobase as cairo

# Base image "dellelce/uwsgi" is alpine + python3 latest + uwsgi
FROM dellelce/uwsgi

LABEL maintainer="Antonio Dell'Elce"

ARG id=devenv
ARG port=8080

ENV APP  /app/${id}
ENV HOME /root

ENV TZ   "Europe/London"

COPY requirements.txt requirements-dev.txt /work/

COPY ${id}   ${HOME}
COPY vimrc   ${HOME}/.vimrc
COPY profile ${HOME}/.bashrc

# Packages
RUN apk add bash vim wget gawk openssh-client   \
            gcc g++ git libc-dev make           \
            cmake bison                         \
            perl                                \
            linux-headers                       \
            nodejs npm go                       \
            bind-tools file xz tzdata

# Python configuration
RUN   mkdir -p "/work/env"  && \
      cd "/work/env" && \
      ${INSTALLDIR}/bin/python3 -m venv . && \
      . /work/env/bin/activate     && \
      pip install --no-cache-dir -U pip setuptools && \
      pip install --no-cache-dir -r /work/requirements-dev.txt && \
      rm /work/requirements-dev.txt && \
      rm /work/requirements.txt

# Cairo Install
COPY --from=cairo /app/cairo /app/cairo
ENV LD_LIBRARY_PATH /app/cairo/lib:${LD_LIBRARY_PATH}
RUN PKG_CONFIG_PATH=/app/cairo/lib/pkgconfig "/work/env/bin/pip" install pycairo

# install mkit
RUN v=master; cd && wget -O mkit.tar.gz -q "https://github.com/dellelce/mkit/archive/${v}.tar.gz" && \
    tar xf mkit.tar.gz && mv mkit-* mkit && ln -s ../mkit/mkit.sh bin && rm mkit.tar.gz

# install devops kit
RUN v=master; cd && wget -O devops.tar.gz -q "https://github.com/dellelce/devops-kit/archive/${v}.tar.gz" && \
    tar xf devops.tar.gz && mv devops-* devops && rm devops.tar.gz

ENV PATH "${HOME}/mkit:${PATH}"

WORKDIR /work
ENTRYPOINT ["/bin/bash"]

## EOF ##
