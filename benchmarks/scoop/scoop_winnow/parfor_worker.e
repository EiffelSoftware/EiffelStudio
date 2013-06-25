class PARFOR_WORKER
create make
feature
  make (start_, final_: INTEGER;
        ncols_, nelts_: INTEGER;
        matrix_array_, mask_array_: separate ARRAY2[INTEGER];
        v_vector_, x_vector_, y_vector_: separate ARRAY [INTEGER])
    do
      start := start_
      final := final_
      ncols := ncols_
      nelts := nelts_
      matrix_array := matrix_array_
      mask_array := mask_array_
      v_vector := v_vector_
      x_vector := x_vector_
      y_vector := y_vector_
    end

feature
  live
    do
      get_result(fetch_array (matrix_array),
                 fetch_array (mask_array))
    end


  fetch_array (a_sep_array: separate ARRAY2[INTEGER]): ARRAY2 [INTEGER]
    require
      a_sep_array.generator /= Void
    local
      i, j: INTEGER
      e: INTEGER
    do
      create Result.make_filled (0, final - start + 1, ncols)

      from i := start
      until i > final
      loop
        from j := 1
        until j > ncols
        loop
          e := a_sep_array.item (i, j)
          Result [to_local_row (i), j] := e
          j := j + 1
        end
        i := i + 1
      end
    end
  
  
  to_local_row (i: INTEGER): INTEGER
    do
      Result := i - start + 1
    end
  
  get_result(a_matrix, a_mask: ARRAY2[INTEGER])
    local
      i, j: INTEGER
      count: INTEGER
      val: VALUE3
    do
      create vector.make (10)

      from
        count := 1
        i := start
      until
        i > final
      loop
        from j := 1
        until j > ncols
        loop
          if a_mask [to_local_row (i), j] = 1 then
            create val.make (a_matrix [to_local_row (i), j], i, j)
            vector.extend (val)
            count := count + 1
          end
          j := j + 1
        end
        i := i + 1
      end
    end

  values_count: INTEGER
    do
      Result := vector.count
    end

  vec_item_x (i: INTEGER): INTEGER
    do
      Result := vector [i].x
    end

  vec_item_v (i: INTEGER): INTEGER
    do
      Result := vector [i].v
    end

  vec_item_y (i: INTEGER): INTEGER
    do
      Result := vector [i].y
    end
  
  
feature {NONE}
  vector: ARRAYED_LIST [VALUE3]

  start, final: INTEGER
  nelts: INTEGER
  ncols: INTEGER
  matrix_array, mask_array: separate ARRAY2[INTEGER]
  v_vector, x_vector, y_vector: separate ARRAY [INTEGER]

end
