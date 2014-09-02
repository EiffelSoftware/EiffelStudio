class TUPLE_SORTER
create
  make

feature
  make()
  do
    create comparator
  end

  sort(values: separate ARRAY[TUPLE[INTEGER, INTEGER, INTEGER]])
    : ARRAY[TUPLE[INTEGER, INTEGER, INTEGER]]
  local
    local_values: ARRAY[TUPLE[INTEGER, INTEGER, INTEGER]]
  do
    create local_values.make_empty
    across 1 |..| values.count as ic loop
      local_values.force(to_local_tuple(values.item(ic.item)), ic.item)
    end
    sort_impl(1, values.count + 1, local_values)
    Result := local_values
  end

  to_local_tuple(t: separate TUPLE[INTEGER, INTEGER, INTEGER])
    : TUPLE[INTEGER, INTEGER, INTEGER]
  do
    Result := [
        t.integer_32_item(1),
        t.integer_32_item(2),
        t.integer_32_item(3)]
  end

  sort_impl(first, last: INTEGER;
    values: ARRAY[TUPLE[INTEGER, INTEGER, INTEGER]])
  local
    pivot_index, spot: INTEGER
    pivot: TUPLE[INTEGER, INTEGER, INTEGER]
  do
    if (first + 1 >= last) then
      -- return
    else
      pivot_index := (first + last) // 2
      pivot := values.item(pivot_index)
      swap(values, pivot_index, last - 1)
      spot := first
      across first |..| (last - 1) as ic loop
        if (comparator.less_than(values.item(ic.item),
              pivot)) then
          swap(values, ic.item, spot)
          spot := spot + 1
        end
      end
      swap(values, spot, last - 1)
      pivot_index := spot

      -- this calls should happen in parallel
      sort_impl(first, pivot_index, values)
      sort_impl(pivot_index + 1, last, values)
    end
  end

  swap(values: ARRAY[TUPLE[INTEGER, INTEGER, INTEGER]];
    i, j: INTEGER)
  local
    temp: TUPLE[INTEGER, INTEGER, INTEGER]
  do
    temp := values.item(i)
    values.put(values.item(j), i)
    values.put(temp, j)
  end

feature {NONE}
  comparator: TUPLE_COMPARATOR

end
