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
CMD="$EXEC -r 1 -r2 3 -g 0.3 -fs $RESDIR/cif_examples/722626.cif -o options,formula,time,vol,cavities -q"

EXPFILE=`basename $0 .bash`

if [[ "$2" == "update"  ]]; then
  echo UPDATING - CIF file 1 without unit cell
  $CMD > $DIR/expected/$EXPFILE

else
  EXP=$(<$DIR/expected/$EXPFILE)

  # run test
  echo TESTING - CIF file 1 without unit cell:
  /bin/bash $DIR/aux/anytest.bash "$CMD" "$EXP"
fi
