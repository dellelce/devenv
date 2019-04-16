#
FROM dellelce/cairobase as cairo

# Base image "dellelce/uwsgi" is alpine + python3 latest + uwsgi
FROM dellelce/uwsgi

LABEL maintainer="Antonio Dell'Elce"

ARG id=devenv
ARG port=8080

ENV APP /app/${id}
ENV HOME /root

COPY requirements.txt requirements-dev.txt ${APP}/

COPY ${id}   ${APP}/home/
COPY vimrc   ${HOME}/.vimrc
COPY profile ${HOME}/.bashrc


COPY --from=cairo /app/cairo /app/cairo

# Shell configuration
RUN apk add bash vim wget gawk gcc openjdk8 maven

# Python configuration
RUN   mkdir -p "${APP}/env"  && \
      cd "${APP}/env" && \
      ${INSTALLDIR}/bin/python3 -m venv . && \
      . ${APP}/env/bin/activate     && \
      pip install --no-cache-dir -U pip setuptools && \
      pip install --no-cache-dir -r ${APP}/requirements-dev.txt && \
      rm ${APP}/requirements-dev.txt && \
      rm ${APP}/requirements.txt

WORKDIR ${APP}

ENTRYPOINT /bin/bash

## EOF ##
