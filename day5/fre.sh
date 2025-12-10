#!/bin/bash
ranges=$(grep "-" input.txt)
ids=$(grep -v "-" input.txt | grep -v '^$')
num_ranges=$(echo "$ranges" | wc -l)
num_ids=$(echo "$ids" | wc -l)
fresh_count=0

#echo "Number of ranges: $num_ranges"
#echo "Number of ids: $num_ids"

# for (( i=1; i<=num_ranges; i++ )); do
#   current_range=$(echo "$ranges" | sed -n "${i}p")
#   min=${current_range//-*/}
#   max=${current_range//*-/}
#   for (( j=1; j<=num_ids; j++ )); do
#     current_id=$(echo "$ids" | sed -n "${j}p")
#     if (( $current_id >= $min && $current_id <= $max )); then
#       echo "value $j within range $i, proceeding"
#       ((fresh_count++))
#       break
#     fi
#   done
# done



  for (( j=1; j<=num_ids; j++ )); do
    current_id=$(echo "$ids" | sed -n "${j}p")

    for (( i=1; i<=num_ranges; i++ )); do
      current_range=$(echo "$ranges" | sed -n "${i}p")
      min=${current_range//-*/}
      max=${current_range//*-/}

      if (( $current_id >= $min && $current_id <= $max )); then
        echo "value $j within range $i, proceeding"
        ((fresh_count++))
        break
      fi

    done


  done


echo $fresh_count

