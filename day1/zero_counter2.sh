#!/bin/bash

i=50;
line_count=4269;
line_number=1;
zero_count=0;
input=input.txt;
min=0;
max=99;

while [ "$line_number" -le "$line_count" ]; do

  current_position=$(sed "${line_number}!d" "$input")

  prev_i=$i
  zero_events_this_move=0

  if [[ "$current_position" == *R* ]]; then
    echo "found an R buddy"
    current_value="${current_position//R/}"
    steps=$(( current_value ))

    full_turns=$(( steps / 100 ))
    remainder=$(( steps % 100 ))

    zero_events_this_move=$full_turns

    if (( remainder > 0 )); then
      if (( prev_i + remainder >= 100 )); then
        ((zero_events_this_move++))
      fi
    fi

    (( i = (prev_i + steps) % 100 ))

  elif [[ "$current_position" == *L* ]]; then
    echo "found an L buddy"
    current_value="${current_position//L/}"
    steps=$(( current_value ))

    full_turns=$(( steps / 100 ))
    remainder=$(( steps % 100 ))

    zero_events_this_move=$full_turns

    if (( remainder > 0 && prev_i > 0 && remainder >= prev_i )); then
      ((zero_events_this_move++))
    fi

    (( i = (prev_i - steps) % 100 ))
    (( i < 0 ? i += 100 : 0 ))

  fi

  if (( zero_events_this_move > 0 )); then
    ((zero_count += zero_events_this_move))
    echo "zero events this move: $zero_events_this_move"
  else
    echo "not 0"
  fi

  echo "line $line_number : value $current_position -> i=$i"

  ((line_number++))
done

echo $zero_count

