# vim:syntax=bash

export PS1='\$ '
alias vi=vim

[ -f "${APP}/env/bin/activate" ] && . ${APP}/env/bin/activate
[ ! -z "${INSTALLDIR}" -a -d "${INSTALLDIR}/bin" ]  && export PATH="${INSTALLDIR}/bin:$PATH"

d="/usr/lib/jvm/java-1.8-openjdk"
[ -d "${d}" ] && { export PATH="${PATH}:${d}/bin"; export JAVA_HOME="${d}"; }

unset d
