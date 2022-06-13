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

GRIDS=(0.5 0.4 0.3 0.2 0.15 0.1 0.05)

echo "Grid; Time; Cav1; Cav2"

for G in "${GRIDS[@]}"
do
  CMD="time $EXEC -r 1.2 -fs $RESDIR/example_C60.cif -uc -g $G -o cavities,time -q"

  # run test
  echo "$G; `$CMD`"
done
