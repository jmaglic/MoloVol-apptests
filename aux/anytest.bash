#!/bin/bash

CMD="$1" # command without -fe flag
EXP="$2" # expected result

# get directory of the bash file
DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi

# get resource directory
RESDIR=$(<$DIR/../data/resdir)

# run command
CMD="$CMD -fe $RESDIR/elements.txt"
OUT=`$CMD`

RED='\033[0;31m'
GREEN='\033[0;32m'
NOCOL='\033[0m'

# compare output against expected result
if [[ "$OUT" != "$EXP" ]]
  then 
    COMP=`/bin/bash $DIR/compare.bash "$OUT" "$EXP"`
    echo "$COMP"
    if [[ "$COMP" == *"Mismatch"* ]]
    then
      echo -e ${RED}failed${NOCOL}
    else
      echo -e ${GREEN}passed${NOCOL}
    fi
  else
    echo -e ${GREEN}passed${NOCOL}
fi
