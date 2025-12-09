#!/bin/bash

input=$(cat input.txt)
line_count=$(cat input.txt | wc -l)
line_number=1
total_joltage=0

while [ $line_number -le $line_count ]; do

  line_content=$(sed -n "${line_number}p" input.txt)
  digit_count=${#line_content}

  echo "Line number: $line_number"
  echo "Line content: $line_content"
  echo "Digit count: $digit_count"

  if [ $digit_count -lt 2 ]; then
    ((line_number++))
    continue
  fi

  digit1=-1
  idx1=-1

  for ((i=0; i<digit_count-1; i++)); do
    current_digit="${line_content:i:1}"

    if ! [[ "$current_digit" =~ ^[0-9]$ ]]; then
      continue
    fi

    if [ "$current_digit" -gt "$digit1" ]; then
      digit1=$current_digit
      idx1=$i
    fi
  done

  digit2=-1

  if [ $idx1 -ge 0 ]; then
    for ((i=idx1+1; i<digit_count; i++)); do
      current_digit="${line_content:i:1}"

      if ! [[ "$current_digit" =~ ^[0-9]$ ]]; then
        continue
      fi

      if [ "$current_digit" -gt "$digit2" ]; then
        digit2=$current_digit
      fi
    done
  fi

  if [ "$digit1" -ge 0 ] && [ "$digit2" -ge 0 ]; then
    concat="${digit1}${digit2}"
    ((total_joltage+=concat))
    echo "digit1: $digit1"
    echo "digit2: $digit2"
    echo "concat: $concat"
  fi

  ((line_number++))

done

echo "total joltage: $total_joltage"

