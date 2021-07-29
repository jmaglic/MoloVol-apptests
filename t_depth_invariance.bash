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

EXPFILE=`basename $0 .bash`

if [[ "$2" == "update"  ]]; then
  echo UPDATING - Depth invariance for all depths
  CMD="$EXEC -r 1 -g 0.1 -fs $RESDIR/acetylene.xyz -d 4 -o vol_vdw,vol_inaccessible -q"
  $CMD > $DIR/expected/$EXPFILE

else
  EXP=$(<$DIR/expected/$EXPFILE)

  DEPTHS=(0 1 2 3 4 5 6 7 8 9)

  for D in "${DEPTHS[@]}"
  do
    CMD="$EXEC -r 1 -g 0.1 -fs $RESDIR/acetylene.xyz -d $D -o vol_vdw,vol_inaccessible -q"

    # run test
    echo TESTING - Depth invariance for depth $D:
    /bin/bash $DIR/aux/anytest.bash "$CMD" "$EXP"
  done
fi
