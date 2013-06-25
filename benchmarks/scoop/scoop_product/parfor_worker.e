class PARFOR_WORKER
create make
feature
  make (start_, final_, nelts_: INTEGER;
        matrix_: separate ARRAY2[DOUBLE];
        vector_: separate ARRAY[DOUBLE];
        result_vector_: separate ARRAY[DOUBLE])
    do
      start := start_
      final := final_
      nelts := nelts_
      matrix := matrix_
      vector := vector_
      result_vector := result_vector_
    end

feature
  live
    do
      get_result(fetch_array(matrix), fetch_vector (vector))
    end

  
  fetch_array (a_sep_array: separate ARRAY2[DOUBLE]): ARRAY2 [DOUBLE]
    require
      a_sep_array.generator /= Void
    local
      i, j: INTEGER
      e: DOUBLE
    do
      create Result.make_filled (0, final - start + 1, nelts)

      from i := start
      until i > final
      loop
        from j := 1
        until j > nelts
        loop
          e := a_sep_array.item (i, j)
          Result [to_local (i), j] := e
          j := j + 1
        end
        i := i + 1
      end
    end
  
  fetch_vector (a_sep_vector: separate ARRAY [DOUBLE]): ARRAY [DOUBLE]
    require
      a_sep_vector.generator /= Void
    local
      i: INTEGER
      e: DOUBLE
    do
      create Result.make_filled (0, 1, nelts)

      from i := 1
      until i > nelts
      loop
        e := a_sep_vector.item (i)
        Result [i] := e
        i := i + 1
      end
    end
  
  
  to_local (i: INTEGER): INTEGER
    do
      Result := i - start + 1
    end
  
  get_result(a_matrix: ARRAY2[DOUBLE];
             a_vector: ARRAY[DOUBLE])
    local
      i, j: INTEGER
      sum: DOUBLE
      res: ARRAY [DOUBLE]
    do
      create res.make_filled (0, 1, final - start + 1)
      
      from i := start
      until i > final
      loop
        sum := 0
        from j := 1
        until j > nelts
        loop
          sum := sum + a_matrix [to_local (i), j] * a_vector [j]
          j := j + 1
        end
        res [to_local (i)] := sum
        i := i + 1
      end

      send_result (res, result_vector)
    end

  send_result (a_vector: ARRAY [DOUBLE];
               a_result_vector: separate ARRAY[DOUBLE])
    local
      i: INTEGER
    do
      from i := start
      until i > final
      loop
        a_result_vector [i] := a_vector [to_local (i)]
        i := i + 1
      end
    end

feature {NONE}
  nelts, start, final: INTEGER
  matrix: separate ARRAY2[DOUBLE]
  vector, result_vector: separate ARRAY[DOUBLE]

end
