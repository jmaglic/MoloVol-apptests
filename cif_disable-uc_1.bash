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

# set expected result for command
EXP="<OPTIONS>
Enable two-probe mode: yes
Calculate surface areas: no
<OUTPUT>
Result for: C52H70Cl7O9
Elapsed time: 0.347358 s
<VOLUME>
Van der Waals volume: 990.279000 A^3
Probe inaccessible volume: 207.468000 A^3
Small probe core volume: 0.162000 A^3
Small probe shell volume: 8.181000 A^3
Large probe core volume: No physical meaning, contains all volume outside the structure.
Large probe shell volume: 4897.881000 A^3
Cavity ID           Volume              Core Surface        Shell Surface       Position            
                    (A^3)               (A^2)               (A^2)               (A,A,A)             
1                   4.509000            0.000000            0.000000            (16, 14, 3.9)       
2                   3.834000            0.000000            0.000000            (10, 9, 16)  "

# run test
echo TESTING - CIF file 1 without unit cell:
/bin/bash $DIR/aux/anytest.bash "$CMD" "$EXP"
