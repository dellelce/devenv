#
# no ssl verification for git, OMG!!
#
export GIT_SSL_NO_VERIFY=1

[ -z "$GITDIR" ] && export GITDIR="/c/data/git"

mkgit()
{
 typeset pkg="$1"

 [ -z "$pkg" ] && return 1

 typeset letter="$(echo $pkg | cut -b1)"
 typeset pkgdir="$GITDIR/$letter/$pkg"

 [ -d "$pkgdir" ] && { echo "directory $pkgdir already exists"; return 1; }

 mkdir -p "$pkgdir" || { echo "failed creating directory $pkgdir"; return 2; }

 typeset cwd="$PWD"
 cd "$pkgdir" || { echo "failed changing directory to $pkgdir"; return 3; }

 git --bare init

 cd "$cwd"
}

# add a 'local' origin
gitorigin()
{
 typeset pkg="$1"

 [ -z "$pkg" ] && return 1

 typeset letter="$(echo $pkg | cut -b1)"
 typeset pkgdir="$GITDIR/$letter/$pkg"

 # we should add more sanity tests here!!!
 [ ! -d "$pkgdir" ] && { echo "$pkgdir does not exist"; return 1; }

 [ -f ".git/config" ] &&
 {
   git remote add l-origin $pkgdir
 } ||
 {
   git init
   git remote add origin $pkgdir
 }
}

lsgit()
{
 typeset dir=""

 for dir in $GITDIR/?/*
 do
  echo $dir
 done | awk ' { cnt = split($0, a, "/"); print a[cnt]; } '
}

#
#
#
localclone()
{
  typeset pkg="$1"

  [ -z "$pkg" ] && return 1

  typeset letter="$(echo $pkg | cut -b1)"
  typeset pkgdir="$GITDIR/$letter/$pkg"

  # we should add more sanity tests here!!!
  [ ! -d "$pkgdir" ] && { echo "$pkgdir does not exist"; return 1; }

  git clone "$pkgdir"
}

# tagnow
# create a tag with current time stamp
#
tagnow()
{
 typeset tag=$(now)

 git tag ${tag}
}

# shortcut to git push
gp()
{
 git pull && git push && git status
}

# shortcut to git status - gs is ghostscript
gits()
{
 git status
}

# git status -uno
gsno()
{
 git status -uno
}

# get root directory of our repo
reporoot()
{
 git rev-parse --show-toplevel 2>/dev/null
}

#
# gls
#
gls()
{
 git ls-files $*
}

#
# gss
#
gss()
{
 git submodule status $*
}

#
# bbremote
#
bbremote()
{
 typeset remote="$1"

 [ -z "$remote" ] && return 1
 git remote add bb "$remote"
}

#
#
#
gitfile()
{
 typeset fn="$1"; shift
 typeset comment="$1"; shift
 typeset content="$1"; shift

 [ -z "$fn" ] &&
 {
  echo "gitfile filename comment content (use quotes)"
  return 1
 }

 echo "$comment" > "$fn" &&
 git add -A "$fn" &&
 git commit -m "$comment"
 return $?
}

#
#githelp
# help for my custom git functions

githelp()
{
cat << EOF

mkgit	   create a new "local" git repo
gitorigin  add a "local" origin
lsgit	   list all local git repos
localclone clone a local package
tagnow	   add a tag with current timestamp
gp	   git: push & status
gits 	   git status
gls        git ls-files
gss        git submodule status
gitline
bbremote   add a bitbucket remote
gitfile

EOF
}

## EOF ##
