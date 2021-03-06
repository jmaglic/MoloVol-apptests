#!/bin/bash

if [[ -z "$1" ]]
  then
    echo Executable missing
    exit
fi

EXEC="$1" # path to executable

# get directory of the bash file
DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi

# get resource directory
RESDIR=$(<$DIR/data/resdir)

# set command without -fe
CMD="$EXEC -r 1.2 -g 0.1 -fs $RESDIR/probetest_quadruplet.xyz -o vol_inaccessible -q"

EXPFILE=`basename $0 .bash`

if [[ "$2" == "update"  ]]; then
  echo UPDATING - Excluded volume quadruplet
  $CMD > $DIR/expected/$EXPFILE

else
  EXP=$(<$DIR/expected/$EXPFILE)

  # run test
  echo TESTING - Excluded volume quadruplet:
  /bin/bash $DIR/aux/anytest.bash "$CMD" "$EXP"
fi
