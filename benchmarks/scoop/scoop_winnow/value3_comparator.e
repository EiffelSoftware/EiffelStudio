class VALUE3_COMPARATOR
inherit PART_COMPARATOR[VALUE3]
feature
  less_than(u, v: VALUE3): BOOLEAN
    do
      if u.v /= v.v then
        Result := u.v < v.v
      elseif u.x /= v.x then
        Result := u.x < v.x
      else
        Result := u.y < v.y
      end
    end
end
