#!/bin/bash

find_repeated_pattern() {
  local s=$1
  local len=${#s}

  # Must be splittable into exactly 2 equal halves
  (( len % 2 == 0 )) || return 1

  local half=$(( len / 2 ))
  local left=${s:0:half}
  local right=${s:half}

  if [[ $left == "$right" ]]; then
    printf '%s\n' "$left"
    return 0
  else
    return 1
  fi
}

i=1
matches=0
total=0
input=$(cat input.txt)

IFS=',' read -r -a fields <<< "$input"

for field in "${fields[@]}"; do
  IFS='-' read -r -a bounds <<< "$field"
  echo "field $i"
  echo "lower bound: ${bounds[0]}"
  echo "upper bound: ${bounds[1]}"
  min="${bounds[0]}"
  max="${bounds[1]}"
  current=$min

  while (( current <= max )); do

    if pat=$(find_repeated_pattern "$current"); then
      echo "$current: match on $pat and $pat"

      ((total+=$current))
      ((matches++))
    fi

    ((current++))
  done

  ((i++))

done

echo $matches
echo $total

