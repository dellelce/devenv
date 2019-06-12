# Docker image used to test/develop inside my standard docker environment
FROM dellelce/cairobase as cairo

# Base image "dellelce/uwsgi" is alpine + python3 latest + uwsgi
FROM dellelce/uwsgi

LABEL maintainer="Antonio Dell'Elce"

ARG id=devenv
ARG port=8080

ENV APP /app/${id}
ENV HOME /root

COPY requirements.txt requirements-dev.txt ${APP}/

COPY ${id}   ${HOME}
COPY vimrc   ${HOME}/.vimrc
COPY profile ${HOME}/.bashrc

# Shell configuration
RUN apk add bash vim wget gawk openssh-client   \
            gcc g++ git libc-dev make           \
            openjdk8 maven gradle               \
            nodejs npm go                       \
            bind-tools file xz

# Python configuration
RUN   mkdir -p "${APP}/env"  && \
      cd "${APP}/env" && \
      ${INSTALLDIR}/bin/python3 -m venv . && \
      . ${APP}/env/bin/activate     && \
      pip install --no-cache-dir -U pip setuptools && \
      pip install --no-cache-dir -r ${APP}/requirements-dev.txt && \
      rm ${APP}/requirements-dev.txt && \
      rm ${APP}/requirements.txt

# Cairo Install
COPY --from=cairo /app/cairo /app/cairo
ENV LD_LIBRARY_PATH /app/cairo/lib:${LD_LIBRARY_PATH}
RUN PKG_CONFIG_PATH=/app/cairo/lib/pkgconfig "${APP}/env/bin/pip" install pycairo

# install mkit
RUN v=0.0.37; cd && wget -O mkit.tar.gz -q "https://github.com/dellelce/mkit/archive/${v}.tar.gz" && \
    tar xf mkit.tar.gz && mv mkit-* mkit && ln -s ../mkit/mkit.sh bin && rm mkit.tar.gz

ENV PATH "${HOME}/mkit:${PATH}"

WORKDIR ${APP}
CMD ["/bin/bash"]

## EOF ##
