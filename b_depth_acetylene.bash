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

DEPTHS=(0 1 2 3 4 5 6 7 8 9 10)

echo "Depth; Time"

for D in "${DEPTHS[@]}"
do
  CMD="$EXEC -r 1.2 -fs $RESDIR/acetylene.xyz -g 0.1 -o time -q -d $D"

  # run test
  echo $D: `$CMD`
done
