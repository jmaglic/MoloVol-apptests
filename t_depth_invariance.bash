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

EXP="<VOLUME>
Van der Waals volume: 37.750000 A^3
Probe inaccessible volume: 0.040000 A^3"

DEPTHS=(0 1 2 3 4 5 6 7 8 9)

for D in "${DEPTHS[@]}"
do
  CMD="$EXEC -r 1 -g 0.1 -fs $RESDIR/acetylene.xyz -d $D -o vol_vdw,vol_inaccessible -q"

  # run test
  echo TESTING - Depth invariance for depth $D:
  /bin/bash $DIR/aux/anytest.bash "$CMD" "$EXP"
done
