#

#
# repotmp
#
repotmp()
{
 typeset repoRoot=$(reporoot)

 [ -z "$repoRoot" ] && { echo "not in a git repo?"; return 1; }

 typeset gitIgnore="${repoRoot}/.gitignore"
 typeset tmpDir="${repoRoot}/tmp"
 typeset tmpReadMe="${repoRoot}/tmp/README.md"
 typeset msg="untracked tmp directory"
 typeset rc=0
 typeset commitCnt=0
 unset statusTmp statusIgn commitList

 # check if tmp exists
 [ ! -d "$tmpDir" ] &&
 {
  mkdir "${tmpDir}" || return
 }

 [ ! -f "$tmpReadMe" ] &&
 {
  echo "$msg" > "${tmpReadMe}" || return
 }

 # check if README is versioned
 typeset statusTmp=$(git status --porcelain "${tmpReadMe}" |
                      awk ' { print $1 } ')
 [ "$statusTmp" == "??" ] &&
  { git add -f "${tmpReadMe}"; commitList="${tmpReadMe}"; commitCnt=1; }

 # check if .gitignore exists and has tmp in it
 [ ! -f "$gitIgnore" ] &&
 {
  echo 'tmp' > $gitIgnore
 } ||
 {
  typeset tmpCnt=$(cat $gitIgnore | awk '
     BEGIN { cnt = 0; }
     $0 == "tmp" { cnt = cnt + 1 }
     END { print cnt }
')
  [ "$tmpCnt" -eq 0 ] && { echo "tmp" >> ${gitIgnore}; let commitCnt="(( $commitCnt + 1 ))"; commitList="${commitList} ${gitIgnore}"; }
 }

 # check: is .gitignore versioned
 typeset statusIgn=$(git status --porcelain "${gitIgnore}" |
                      awk ' { print $1 } ')

 [ "$statusIgn" == "??" ] &&
  { git add -f "${gitIgnore}"; commitList="${commitList} ${gitIgnore}";
    let commitCnt="(( $commitCnt + 1 ))"
  }
 [ "$commitCnt" -ne 0 ] && { git commit -m "${msg}" ${commitList}; return; }

 return 0
}

## EOF ##
