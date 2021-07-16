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
CMD="$EXEC -r 1 -g 0.3 -fs $RESDIR/cif_examples/722626.cif -o options,formula,time,vol,cavities -q -uc"

# set expected result for command
EXP="<OPTIONS>
Enable two-probe mode: no
Calculate surface areas: no
<OUTPUT>
Result for: C312H420Cl42O54
Elapsed time: 0.982420 s
<VOLUME>
Van der Waals volume: 5556.814509 A^3
Probe inaccessible volume: 2363.911413 A^3
Probe core volume: 0.606928 A^3
Probe shell volume: 28.795311 A^3
Cavity ID           Volume              Core Surface        Shell Surface       Position            
                    (A^3)               (A^2)               (A^2)               (A,A,A)             
1                   11.286000           0.000000            0.000000            (13, 7.7, 6.5)      
2                   5.213700            0.000000            0.000000            (25, 15, 7.2)       
3                   4.860000            0.000000            0.000000            (0.6, 15, 7.2)      
4                   2.024469            0.000000            0.000000            (13, 22, 0.6)       
5                   1.629293            0.000000            0.000000            (13, 22, 13)        
6                   1.215000            0.000000            0.000000            (0.6, 0.6, 0.6)     
7                   1.147697            0.000000            0.000000            (26, 0.6, 13)       
8                   1.053675            0.000000            0.000000            (26, 0.6, 0.6)      
9                   0.972405            0.000000            0.000000            (0.6, 0.6, 13) "

# run test
echo TESTING - CIF file 1 with unit cell:
/bin/bash $DIR/aux/anytest.bash "$CMD" "$EXP"
