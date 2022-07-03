#!/bin/bash

TESTDESC="Charged atoms from CIF file (unit cell)"

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
CMD="$EXEC -r 1.2 -g 0.2 -fs $DIR/structures/charged/norc_cage-ions.cif -o all -q -uc"

EXPFILE=`basename $0 .bash`

if [[ "$2" == "update"  ]]; then
  echo UPDATING - $TESTDESC
  $CMD > $DIR/expected/$EXPFILE

else
  EXP=$(<$DIR/expected/$EXPFILE)

  # run test
  echo TESTING - $TESTDESC:
  /bin/bash $DIR/aux/anytest.bash "$CMD" "$EXP"
fi
