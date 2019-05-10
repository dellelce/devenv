# vim:syntax=bash

export PS1='\$ '
alias vi=vim

[ -f "${APP}/env/bin/activate" ] && . ${APP}/env/bin/activate
[ ! -z "${INSTALLDIR}" -a -d "${INSTALLDIR}/bin" ]  && export PATH="${INSTALLDIR}/bin:$PATH"

# TODO: move java to autoload script
d="/usr/lib/jvm/java-1.8-openjdk"
[ -d "${d}" ] && { export PATH="${PATH}:${d}/bin"; export JAVA_HOME="${d}"; }

# setup SAVEDIRS on volume
[ -d "${APP}/vol" ] &&
{
  export VOL="${APP}/vol"
  [ ! -d "$VOL/savedirs" ] && { mkdir "$VOL/savedirs" ]

  # if the above succeeded we can use it for our SAVEDIRS variable
  export SAVEDIRS="$VOL/savedirs"
}

# Use "external" gitconfig if available
[ -f "$VOL/.gitconfig" ] &&
{
  ln -sf "$VOL/.gitconfig" "$HOME/.gitconfig"
}

[ -f "${HOME}/.autoload" ] && . "${HOME}/.autoload"

unset d

# custom TMP, do we need to move this to a volume?
[ -z "$TMP" ] && { export TMP="$HOME/tmp"; [ ! -d "$TMP" ] && mkdir "$TMP"; }
