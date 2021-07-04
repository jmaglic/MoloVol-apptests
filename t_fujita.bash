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
CMD="$EXEC -r 1 -r2 4 -g 0.3 -fs $RESDIR/Pd6L4_open_cage_Fujita.xyz -o probemode,vol_inaccessible,vol_vdw,vol_core_s,vol_shell_s,cavities,time -q"

# set expected result for command
EXP="<OPTIONS>
Enable two-probe mode: yes
<OUTPUT>
Elapsed time: 1.885320 s
<VOLUME>
Van der Waals volume: 2067.795000 A^3
Probe inaccessible volume: 275.616000 A^3
Small probe core volume: 304.182000 A^3
Small probe shell volume: 261.819000 A^3
Cavity ID           Volume              Core Surface        Shell Surface       Position            
                    (A^3)               (A^2)               (A^2)               (A,A,A)             
1                   566.001000          0.000000            0.000000            (0.3, 17, 25)  "

# run test
echo TESTING - Two probe mode with Fujita cage:
/bin/bash $DIR/aux/anytest.bash "$CMD" "$EXP"
