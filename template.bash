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
CMD="$EXEC -r 1.2 -g 0.1 -fs $RESDIR/file.xyz -o all -q"

# set expected result for command
EXP=""

# run test
echo TESTING - What we are testing:
/bin/bash $DIR/aux/anytest.bash "$CMD" "$EXP"
