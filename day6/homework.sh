#!/bin/bash

awk '
{
  for (field_index=1; field_index<=NF; field_index++) {
    cell_value[NR,field_index] = $field_index
    if (field_index > max_field_count) max_field_count = field_index
  }
  total_row_count = NR
}
END {
  operation_row_number = total_row_count
  data_row_count = total_row_count - 1
  sum_of_column_results = 0

  for (field_index=1; field_index<=max_field_count; field_index++) {
    operation = cell_value[operation_row_number, field_index]
    if (operation == "") continue

    column_result = cell_value[1, field_index] + 0

    for (row_index=2; row_index<=data_row_count; row_index++) {
      value = cell_value[row_index, field_index] + 0

      if (operation == "+") column_result += value
      else if (operation == "-") column_result -= value
      else if (operation == "*") column_result *= value
      else if (operation == "/") column_result /= value
      else continue
    }

    printf "%s", cell_value[1, field_index]
    for (row_index=2; row_index<=data_row_count; row_index++) {
      printf "%s%s", operation, cell_value[row_index, field_index]
    }
    printf "=%s\n", column_result

    sum_of_column_results += column_result
  }

  printf "sum=%s\n", sum_of_column_results
}' input.txt

