#

tmpproj_check()
{
 echo
}

tmpproj_usage()
{
 cat << EOF
 usage: tmpproj id [virtualenv=virtualenvdir]
                   [pipinstall=pip pars]
                   [wget=wget pars]
                   [modules=name:url]
                   [modules=url]
EOF
}

tmpproj()
{
 typeset r="README.md"
 typeset base="$HOME/tmp"
 typeset wd="$PWD"
 typeset now="$(date +%H%m%y)"
 typeset rc=0
 typeset p="$1"; shift

 [ -z "$p" ] && { tmpproj_usage; return 1; }

 typeset fp="$base/$p"
 [ -d "$fp" ] && { echo "directry $fp already exists."; return 1; }
 mkdir "$fp" || { echo "failed creating $fp"; return 1; }

 cd "$fp"
 git init && {
 {
  cat << EOF
# Project $p

Created $now
EOF
} > $r
} && git add $r && git commit -m 'Initial readme' && repotmp

 rc_main=$?
 [ $rc_main -ne 0 ] && return $rc_main

 # process other arguments if any
 typeset venv=""
 typeset arg=""
 typeset rc_env

 for arg in $*
 do
  [ "$arg" != "${arg#virtualenv=}" ] &&
  {
   venv="${arg#virtualenv=}"
   echo "action: virtualenv=$venv"

   mkdir "$venv";
   [ $? -ne 0 ] && continue # just ignore it for now
   cd "$venv"
   # we support *ONLY* python3
   python3 -m venv .
   rc_env="$?"
   cd -

   [ "$rc_env" -eq 0 ] &&
   {
     echo "# untracked virtualenv directory" > "$venv/README.md"
     git add "$venv/README.md"
     echo "$venv" >> .gitignore
     git add .gitignore
     git commit -m 'untracked virtualenv directory'
     [ -f "$venv/bin/activate" ] && { activate="yes"; . $venv/bin/activate; rc_activate=$?; }
     [ "$activate" == "yes" -a "$rc_activate" -eq 0 ] && pip install -U pip setuptools
   } ||
   {
     rm -rf "$venv" # remove all stuff and continue (for now)...
     continue
   }
  } # end: virtualenv

  [ "$arg" != "${arg#pipinstall=}" ] &&
  {
   typeset pipinstall="${arg#pipinstall=}"
   typeset req="" reqs="requirements.txt"

   echo "action: pipinstall=$pipinstall"
   [ -z "$venv" ] && { echo "pip install needs a virtualenv. Skipping."; continue; }

   # create requirement.txt
   {
    for req in $pipinstall
    do
     echo $req
    done
   } > "$reqs"

   [ -s "$reqs" ] &&
   {
    git add "$reqs" && git commit -m "initial ${reqs}"
    rc_gitreqs="$?"

    pip install -U -r "$reqs"
    rc_pipinstall="$?"
   }
  } # end: pipinstall

  [ "$arg" != "${arg#wget=}" ] &&
  {
   typeset wget="${arg#wget=}"

   echo "action: wget=$wget"

   wget $wget
   rc_wget="$?"
  }

  # shallow clone for submodules or not?
  [ "$arg" != "${arg#shallow=}" ] &&
  {
   shallow="${arg#shallow=}"
   echo "action: shallow=$shallow"
   # setting the shallow variable is enough
  }

  [ "$arg" != "${arg#modules=}" ] &&
  {
   typeset modules="${arg#modules=}"

   echo "action: modules=$modules"

   typeset name url
   for module in $modules
   do
     eval $(
     echo $module | awk -F: '
     NF == 3 { url=$2":"$3; name=$1;
               printf("url=%c%s%c; name=%c%s%c;", 34, url, 34, 34, name, 34);
             }
     NF == 2 { url=$1":"$2;
               name=url
               gsub(/\.git/,"", name);
               cnt = split(name, name_a, "/");
               name = name_a[cnt]
               printf("url=%c%s%c; name=%c%s%c;", 34, url, 34, 34, name, 34);
             }
     NF == 1 { url=$1; name=$1;
               gsub(/\.git/,"", name);
               cnt = split(name, name_a, "/");
               name = name_a[cnt]
               printf("url=%c%s%c; name=%c%s%c;", 34, url, 34, 34, name, 34);
             }
'
     )
     echo "path=$name"
     echo "url=$url"

     typeset git_opts=""
     [ "$shallow" == "yes" ] && git_opts="--depth 2"

     git submodule add -b master $git_opts -- $url $name &&
       git commit -m "submodule: $name" # errors? we just ignore them (for now?!).....
   done
  }
 done

 return 0
}

## EOF ##
