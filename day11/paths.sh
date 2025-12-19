#!/bin/bash

# let's work backward from all the outs
outs=$(grep "out" input.txt)
you=$(grep -o -n "you:" input.txt)
yous=$(grep -o "you" input.txt)

echo "$yous" | awk 'BEGIN { RS = " " } {print $0}'
echo $you

