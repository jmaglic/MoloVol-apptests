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
CMD="$EXEC -r 0.4 -r2 2 -g 0.1 -fs $RESDIR/probetest_quadruplet.xyz -o vol,probemode,time -q"

# set expected result for command
EXP="<OPTIONS>
Enable two-probe mode: yes
<OUTPUT>
Elapsed time: 1.028792 s
<VOLUME>
Van der Waals volume: 28.948000 A^3
Probe inaccessible volume: 1.468000 A^3
Small probe core volume: 1.326000 A^3
Small probe shell volume: 9.270000 A^3
Large probe core volume: No physical meaning, contains all volume outside the structure.
Large probe shell volume: 309.466000 A^3"

# run test
echo TESTING - Two-probe mode:
/bin/bash $DIR/aux/anytest.bash "$CMD" "$EXP"
