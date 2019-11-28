
# mkh
#
# create a C Header file with given name and basic information
#
mkh()
{
 typeset f="$1"

 [ -z "$f" ] && { echo "Missing filename."; return 1; }
 [ -f "$f" -a -s "$f" ] && { echo "File already exists: $f"; return 2; }

 typeset now=$(date +%H%M)" "$(date +%d%m%y)

 typeset hn="$(echo $f | awk ' { sub(/\./,"_"); print toupper($0); } ' )"

{
cat << EOF
/**
  @file    ${f}
  @author  Antonio Dell'elce
  @created ${now}
  @brief
*/

#ifndef __${hn}
/** @cond NoDoc */
#define __${hn} 1
/** @endcond */

// insert code here

#endif /* __${hn} */

/* EOF */
EOF
} > "$f"
}

#
# mkc
#
# create a prototype C program with given name and basic information
#
mkc()
{
 typeset f="$1"

 [ -z "$f" ] && { echo "Missing filename."; return 1; }
 [ -f "$f" -a -s "$f" ] && { echo "File already exists: $f"; return 2; }

 typeset now=$(date +%H%M)" "$(date +%d%m%y)

{
cat << EOF
/*
   File:    ${f}
   Created: ${now}
*/

// includes

// insert code here

// ** EOF **
EOF
} > "$f"
}

mkmain()
{
 typeset f="$1"

 [ -z "$f" ] && { echo "Missing filename."; return 1; }
 [ -f "$f" -a -s "$f" ] && { echo "File already exists: $f"; return 2; }

 typeset now=$(date +%H%M)" "$(date +%d%m%y)

# typeset hn="$(echo $f | awk ' { sub(/\./,"_"); print toupper($0); } ' )"

{
cat << EOF
/*
  File:    ${f}
  Created: ${now}
*/

// includes
#include <stdio.h>

// main
int
main (int argc, char **argv)
{
 // insert code here

 // generic return

 return 0;
}

// ** EOF **
EOF
} > "$f"
}

# mksh
#
mksh()
{
 typeset f="$1"
 typeset sp="/bin/bash"

 [ -z "$f" ] && { echo "Missing filename."; return 1; }
 [ -f "$f" -a -s "$f" ] && { echo "File already exists: $f"; return 2; }

 typeset now=$(date +%d%m%y)

{
cat << EOF
#!${sp}
#
# File:         ${f}
# Created:      ${now}
# Description:  description for ${f}
#

## FUNCTIONS ##

## ENV ##

## MAIN ##

## EOF ##
EOF
} > "$f"

 chmod +x "$f"
}

##
# mkdownload
#

mkdownload()
{
 typeset f="$1"
 typeset u="$2"
 typeset sp="/bin/bash"

 [ -z "$f" ] && { echo "Missing filename."; return 1; }
 [ -z "$u" ] && { echo "Missing URL"; return 1; }
 [ -f "$f" -a -s "$f" ] && { echo "File already exists: $f"; return 2; }

 typeset now=$(date +%H%M)" "$(date +%d%m%y)

{
cat << EOF
#!${sp}
#
# File:         ${f}
# Created:      ${now}
# Description:  downloader
#

## FUNCTIONS ##

mwget ()
{
  typeset clnt="Mozilla/5.0";
  typeset opts="--no-check-certificate";
  [ -z "\$1" ] &&
  {
    echo "Missing url.";
    return 1
  }
  wget \$opts -U "\${clnt}" -c \$*
}

### ENV ###

url="${u}"

### MAIN ###

mwget "\${url}"

### EOF ###
EOF
} > "$f"

 chmod +x "$f"
}

#
#
mkawk()
{
 typeset f="$1"

 [ -z "$f" ] && { echo "Missing filename."; return 1; }
 [ -f "$f" -a -s "$f" ] && { echo "File already exists: $f"; return 2; }

 typeset now=$(date +%H%M)" "$(date +%d%m%y)

 # check if we the .awk extension if NO we add it
# set -x
# [ "${f%.awk}" != "$f" ] && { f="${f}.awk"; }
# set +

{
 cat << EOF
#
# ${f}
#
# created: ${now}
#

## FUNCTIONS ##

## BEGIN RULE ##

BEGIN \
{
 state = 0
}

# custom rules

## END RULE ##

END \
{
 # this is the end loop
}
EOF
} > "$f"

}

# mkpy
#
# creates a basic python skeleton script
#
mkpy()
{
 typeset f="$1"

 [ -z "$f" ] && { echo "Missing filename."; return 1; }
 [ -f "$f" -a -s "$f" ] && { echo "File already exists: $f"; return 2; }

 typeset now=$(date +%d%m%y)

{
cat << EOF
'''
 description for ${f}

 File:         ${f}
 Created:      ${now}
'''

## EOF ##
EOF
} > "$f"

 chmod +x "$f"
}

# mkclasspy
#
# make class py
#
mkclasspy()
{
 typeset f="$1"
 typeset class="${f%.py}"

 [ -z "$f" ] && { echo "Missing filename."; return 1; }
 [ "$class" == "$f" ] && f="${f}.py" # always have .py extension
 [ -f "$f" -a -s "$f" ] && { echo "File already exists: $f"; return 2; }

 typeset now="$(date +%d%m%y)"
 typeset python_ver="${PYTHON_VER:-python3}"

{
 cat << EOF
'''
  ${class} class

 File:         ${f}
 Created:      ${now}
'''

class $class(object):
 '''purpose for ${class}'''

 def __init__(self):
  pass

## EOF ##
EOF
} > "${f}"
}

# mkmainpy
#
# creates a basic "main" python skeleton script
#
mkmainpy()
{
 typeset f="$1"

 [ -z "$f" ] && { echo "Missing filename."; return 1; }
 [ -f "$f" -a -s "$f" ] && { echo "File already exists: $f"; return 2; }

 typeset now=$(date +%d%m%y)

{
cat << EOF
'''
 Description for ${f}

 File:         ${f}
 Created:      ${now}
'''

def sample_function(args):
 pass

#
# main function
#
def main(args):
 cnt = len(args)

 # body

if __name__ == '__main__':
 import sys
 main(sys.argv)

## EOF ##
EOF
} > "$f"

 chmod +x "$f"
}


##
# mkautoload
#
# creates a basic .autoload file
#

mkautoload()
{
 typeset f=".autoload"
 typeset cpj="$(basename $PWD)"

 [ -f "$f" -a -s "$f" ] && { echo "File already exists: $f"; return 2; }

 typeset now=$(date +%d%m%y)

{
cat << EOF
#
# Created:      ${now}
# Description:  autoload file for ${cpj}
#
# vim:syntax=sh
#

## FUNCTIONS ##

## ENV ##

## MAIN ##

# enter your code here

## EOF ##

EOF
} > "$f"

 chmod +x "$f"
}

# mkhtml
#
# create html file
#
mkhtml()
{
 typeset f="$1"

 [ -z "$f" ] && { echo "Missing filename."; return 1; }
 [ -f "$f" -a -s "$f" ] && { echo "File already exists: $f"; return 2; }

 typeset _title="Document Title"
 typeset _bodylayer="body"
 typeset now=$(date +%H%M)" "$(date +%d%m%y)

{
# header
 cat << EOF
<!DOCTYPE html>
<html>
<head>
 <title>${_title}</title>
</head>
<!--
  Created: ${now}
-->
EOF

# body
 cat << EOF
<body>
<div id="${_bodylayer}">
</div>
</body>
</html>
EOF
} > "$f"

}

# mkecho
#
mkecho()
{
 typeset f="$1"
 typeset msg="$*"
 typeset sp="/bin/bash"

 [ -z "$f" ] && { echo "Missing filename."; return 1; }
 [ -f "$f" -a -s "$f" ] && { echo "File already exists: $f"; return 2; }

 typeset now=$(date +%d%m%y)

{
cat << EOF
#!${sp}
#
# File:         ${f}
# Created:      ${now}
# Description:  show some text
#

## MAIN ##

echo "$msg"

## EOF ##
EOF
} > "$f"

 chmod +x "$f"
}

# helpmk
#
# basic help function for mk* scripts
#
helpmk()
{
cat << EOF
mkh
mkc
mkmain
mksh
mkawk
mkpy
mkmainpy
mkautoload
EOF
}

## EOF ##
