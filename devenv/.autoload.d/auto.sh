#
#

autols()
{
 typeset hd="$HOME/.autoload.d"
 typeset i=""
 typeset args="$*"

 [ ! -d "$hd" ] && { echo "invalid autoload directory"; return 1; }

 typeset list=$(
  for i in $hd/*.sh;
  do
    [ -f "$i" ] && echo $i;
  done
 )

 [ -z "$args" ] &&
 {
  for i in $list; do echo $i; done
 } ||
 {
  grep -l $args $list
 }
}

autoed()
{
 typeset hd="$HOME/.autoload.d"
 typeset fn="$1"

 [ -z "$EDITOR" ] && typeset EDITOR="vim"
 [ -z "$fn" ] && return 1
 # Case: input is an existing file
 [ -f "$fn" ] && { $EDITOR "$fn"; return $?; }

 fn="$hd/$fn"

 [ -f "$fn" ] && { $EDITOR "$fn"; return $?; }
 fn="${fn}.sh"
 [ -f "$fn" ] && { $EDITOR "$fn"; return $?; }

 [ -d "$hd" ] &&
 {
   autotemplate > "$fn"
   typeset md5orig=$(cat $fn | md5sum)
   vi "$fn"
   rc=$?
   typeset md5final=$(cat $fn | md5sum)
   [ "$md5final" == "$md5orig" ] && { echo "Removing empty/unmodified file."; rm "$fn"; }

   return $rc
 }

 return 1
}

autotemplate()
{
 cat << EOF
# vim:syntax=sh
#
# created $(date +%H%M\ %d%m%y)
#
EOF
}

autoload()
{
 typeset hd="$HOME/.autoload.d"
 typeset fn="$1"

 [ ! -d "$hd" ] && return 1
 [ -z "$fn" ] && return 2

 [ -f "$fn" ] && { . "$fn"; return $?; }

 fn="$hd/$fn"
 [ -f "$fn" ] && { . "$fn"; return $?; }

 fn="$fn.sh"
 [ -f "$fn" ] && { . "$fn"; return $?; }

 return 1
}

autohelp()
{
cat << EOF
autols
autoed
autoload
EOF
}

## EOF ##
