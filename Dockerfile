#
# Base image "dellelce/uwsgi" is alpine + python3 latest + uwsgi
FROM dellelce/uwsgi

LABEL maintainer="Antonio Dell'Elce"

ARG id=devenv
ARG port=8080

ENV APP /app/${id}

COPY requirements.txt ${APP}/
COPY ${id}  ${APP}/home/
COPY vimrc  ${HOME}/.vimrc

# Shell configuration
RUN apk add bash vim wget gawk

# Python configuration
RUN   mkdir -p "${APP}/env"  && \
      cd "${APP}/env" && \
      ${INSTALLDIR}/bin/python3 -m venv . && \
      . ${APP}/env/bin/activate     && \
      pip install -U pip setuptools && \
      pip install -r ${APP}/requirements.txt && \
      rm ${APP}/requirements.txt 

## EOF ##
