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
CMD="$EXEC -r 1.2 -g 0.1 -fs $RESDIR/probetest_triplet.xyz -o vol_inaccessible -q"

EXPFILE=`basename $0 .bash`

if [[ "$2" == "update"  ]]; then
  echo UPDATING - Excluded volume triplet
  $CMD > $DIR/expected/$EXPFILE

else
  EXP=$(<$DIR/expected/$EXPFILE)

  # run test
  echo TESTING - Excluded volume triplet:
  /bin/bash $DIR/aux/anytest.bash "$CMD" "$EXP"
fi
