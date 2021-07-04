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
CMD="$EXEC -r 1 -g 0.2 -uc -ht -fs $RESDIR/test_unit_cell_1.pdb -o vol,unitcell,hetatm,time,vol,cavities -q"

# set expected result for command
EXP="<OPTIONS>
Include HETATM: yes
Analyze unit cell: yes
<OUTPUT>
Elapsed time: 0.138859 s
<VOLUME>
Van der Waals volume: 92.960000 A^3
Probe inaccessible volume: 0.000000 A^3
Probe core volume: 643.712000 A^3
Probe shell volume: 263.328000 A^3
Cavity ID           Volume              Core Surface        Shell Surface       Position            
                    (A^3)               (A^2)               (A^2)               (A,A,A)             
1                   907.040000          0.000000            0.000000            (5.1, 5.1, 5.1)  "

# run test
echo TESTING - Unit cell 1:
/bin/bash $DIR/aux/anytest.bash "$CMD" "$EXP"
