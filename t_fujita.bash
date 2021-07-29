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
CMD="$EXEC -r 1 -r2 4 -g 0.3 -fs $RESDIR/Pd6L4_open_cage_Fujita.xyz -o probemode,vol_inaccessible,vol_vdw,vol_core_s,vol_shell_s,cavities,time -q"

EXPFILE=`basename $0 .bash`

if [[ "$2" == "update"  ]]; then
  echo UPDATING - Two probe mode with Fujita cage
  $CMD > $DIR/expected/$EXPFILE

else
  EXP=$(<$DIR/expected/$EXPFILE)

  # run test
  echo TESTING - Two probe mode with Fujita cage:
  /bin/bash $DIR/aux/anytest.bash "$CMD" "$EXP"
fi
