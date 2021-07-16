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
CMD="$EXEC -r 1 -g 0.3 -fs $RESDIR/cif_examples/nature20771-s2.cif -o options,formula,time,vol,cavities -q -uc"

# set expected result for command
EXP="<OPTIONS>
Enable two-probe mode: no
Calculate surface areas: no
<OUTPUT>
Result for: C3064B192F768N384O384Pd96Se192
Elapsed time: 16.427073 s
<VOLUME>
Van der Waals volume: 58277.070000 A^3
Probe inaccessible volume: 5857.840800 A^3
Probe core volume: 261959.867102 A^3
Probe shell volume: 57722.119200 A^3
Cavity ID           Volume              Core Surface        Shell Surface       Position            
                    (A^3)               (A^2)               (A^2)               (A,A,A)             
1                   319658.631302       0.000000            0.000000            (32, 32, 47)        
2                   4.590000            0.000000            0.000000            (55, 10, 45)        
3                   4.320000            0.000000            0.000000            (42, 40, 2)         
4                   4.293000            0.000000            0.000000            (8.2, 53, 45)       
5                   3.969000            0.000000            0.000000            (10, 8.2, 49)       
6                   3.942000            0.000000            0.000000            (40, 22, 93)        
7                   1.728000            0.000000            0.000000            (22, 15, 4.5)       
8                   0.513000            0.000000            0.000000            (0.15, 9.7, 67)  "

# run test
echo TESTING - CIF file 2 with unit cell:
/bin/bash $DIR/aux/anytest.bash "$CMD" "$EXP"
