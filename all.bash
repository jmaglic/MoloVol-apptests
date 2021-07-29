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

# run test
if [[ "$2" == "update" ]]; then
  echo UPDATING - All
else
  echo TESTING - All:
fi
for file in $DIR/t_*.bash; do
  /bin/bash $file "$EXEC" $2
done
