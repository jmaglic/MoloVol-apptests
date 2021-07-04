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

CMD="$EXEC -r 1.2 -g 0.2 -fs $RESDIR/6s8y.xyz -q -o vol,time,cavities"

EXP="<OUTPUT>
Elapsed time: 2.717566 s
<VOLUME>
Van der Waals volume: 14337.912000 A^3
Probe inaccessible volume: 4083.024000 A^3
Probe core volume: 113127.488000 A^3
Probe shell volume: 9026.296000 A^3
Cavity ID           Volume              Core Surface        Shell Surface       Position            
                    (A^3)               (A^2)               (A^2)               (A,A,A)             
1                   121965.712000       0.000000            0.000000            (3.6, -5.4, 19)     
2                   26.936000           0.000000            0.000000            (2.5, 6.8, 26)      
3                   25.584000           0.000000            0.000000            (5.1, -2.1, 13)     
4                   21.136000           0.000000            0.000000            (5.2, 3.2, 16)      
5                   15.208000           0.000000            0.000000            (-1.7, 5, 8.9)      
6                   13.624000           0.000000            0.000000            (3.9, 15, 19)       
7                   12.904000           0.000000            0.000000            (2.9, -12, 14)      
8                   10.432000           0.000000            0.000000            (2.2, 16, 20)       
9                   8.336000            0.000000            0.000000            (1.5, 11, 19)       
10                  8.312000            0.000000            0.000000            (-7.5, 2.9, 19)     
11                  8.064000            0.000000            0.000000            (-3.7, 1.3, 13)     
12                  7.976000            0.000000            0.000000            (-4.6, 0.8, 12)     
13                  6.976000            0.000000            0.000000            (-3.2, 0.2, 14)     
14                  6.072000            0.000000            0.000000            (1.8, 0, 3.3)       
15                  5.632000            0.000000            0.000000            (2.6, 9.9, 21)      
16                  5.624000            0.000000            0.000000            (3.2, 10, 21)       
17                  5.256000            0.000000            0.000000            (-4.6, 2, 13)  "

# run test
echo TESTING - Volume of big protein:
/bin/bash $DIR/aux/anytest.bash "$CMD" "$EXP"
