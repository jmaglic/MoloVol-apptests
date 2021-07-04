#!/bin/bash

while read out && read -u 3 exp; do
  if [[ "$out" != "$exp" ]]
  then
    if [[ "$out" != *"time"* ]]
    then
      echo Mismatch found:
    fi
    echo -n "Out: "
    echo $out
    echo -n "Exp: "
    echo $exp
  fi
done < <( printf "%s\n" "$1") 3< <(printf "%s\n" "$2")
