class TUPLE_COMPARATOR
inherit PART_COMPARATOR[TUPLE[INTEGER, INTEGER, INTEGER]]
feature
  less_than(u, v: TUPLE[INTEGER, INTEGER, INTEGER]): BOOLEAN
  local
    left_value, left_i, left_j, right_value, right_i, right_j: INTEGER
  do
    left_value := u.integer_32_item(1)
    left_i := u.integer_32_item(2)
    left_j := u.integer_32_item(3)
    right_value := v.integer_32_item(1)
    right_i := v.integer_32_item(2)
    right_j := v.integer_32_item(3)
    if left_value < right_value then
      Result := true
    elseif left_value > right_value then
      Result := false
    elseif left_i < right_i then
      Result := true
    elseif left_i > right_i then
      Result := false
    else
      Result := left_j < right_j
    end
  end
end
