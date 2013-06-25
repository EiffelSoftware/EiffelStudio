class PARFOR_WORKER

create make

feature
  make (start_, final_, ncols_: INTEGER;
        from_array_: separate ARRAY2[INTEGER];
        threshold_: INTEGER)
    do
      start := start_
      final := final_
      ncols := ncols_
      from_array := from_array_
      threshold := threshold_
    end

feature
  live
    do
      if final >= start then
        get_result(fetch_array (from_array))
      end
    end

  to_local_row (x: INTEGER) : INTEGER
    do
      Result := x - start + 1
    end

  fetch_array (a_sep_array: separate ARRAY2[INTEGER]): ARRAY2 [INTEGER]
    local
      i, j: INTEGER
    do
      create Result.make (final - start + 1, ncols)

      from i := start
      until i > final
      loop
        from j := 1
        until j > ncols
        loop
          Result [to_local_row (i), j] := a_sep_array [i, j]
          j := j + 1
        end
        i := i + 1
      end
    end

  get_result(a_from_array: ARRAY2[INTEGER])
    local
      i, j: INTEGER
      res: INTEGER
    do
      create to_array.make (final - start + 1, ncols)

      from i := start
      until i > final
      loop
        from j := 1
        until j > ncols
        loop
          if a_from_array [to_local_row (i), j] >= threshold then
            to_array [to_local_row(i), j] := 1
          else
            to_array [to_local_row (i), j] := 0
          end
          j := j + 1
        end
        i := i + 1
      end
    end

  get (i,j : INTEGER): INTEGER
    do
      Result := to_array [to_local_row (i), j]
    end
  
  start, final: INTEGER
  
feature {NONE}
  ncols: INTEGER
  to_array: ARRAY2 [INTEGER]

  from_array: separate ARRAY2[INTEGER]
  threshold: INTEGER

end
