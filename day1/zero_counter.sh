#!/bin/bash

i=50;
line_count=4269;
line_number=1;
zero_count=0;
input=input.txt;
min=0;
max=99;

while [ $line_number -le $line_count ]; do


  current_position=$(sed "${line_number}!d" input.txt)

if [[ "$current_position" == *R* ]]; then
  echo "found an R buddy"
  current_value="${current_position//R/}"
  steps=$(( current_value % 100 ))            # reduce big moves

  (( i = (i + steps) % 100 ))                 # wrap 0–99

elif [[ "$current_position" == *L* ]]; then
  echo "found an L buddy"
  current_value="${current_position//L/}"     # e.g. "12"
  steps=$(( current_value % 100 ))            # positive step count

  (( i = (i - steps) % 100 ))                 # may be negative
  (( i < 0 ? i += 100 : 0 ))                  # wrap back into 0–99
fi

if (( i == 0 )); then
  ((zero_count++))
  echo "found 0"
fi

  echo "line $line_number : value $current_position"

  ((line_number++))
done

echo $zero_count

