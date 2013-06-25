class
    WORKER

create
  make

feature {NONE}
  make (start_, final_, nelts_, seed_, percent_,
        win_start_, win_final_, winnow_nelts_: INTEGER)
    do
      print ("making " + start_.out + "%N")
      start := start_
      final := final_
      nelts := nelts_
      seed  := seed_.to_natural_32
      percent := percent_

      win_start := win_start_
      win_final := win_final_
      winnow_nelts := winnow_nelts_

      create matrix.make (1, to_local_row (final))
      create mask.make (1, to_local_row (final))
    end

feature -- Setters
  set_max (max_ : separate ARRAY [INTEGER])
    do
      max := max_
    end

  set_histogram (histogram_ : separate ARRAY [INTEGER])
    do
      histogram := histogram_
    end

  set_vs (vs_ : separate ARRAY [INTEGER])
    do
      vs := vs_
    end

  set_xs (xs_ : separate ARRAY [INTEGER])
    do
      xs := xs_
    end

  set_ys (ys_ : separate ARRAY [INTEGER])
    do
      ys := ys_
    end

  set_winnow_xs (winnow_xs_ : separate ARRAY [INTEGER])
    do
      winnow_xs := winnow_xs_
    end

  set_winnow_ys (winnow_ys_ : separate ARRAY [INTEGER])
    do
      winnow_ys := winnow_ys_
    end

  set_result_vector (result_vector_ : separate ARRAY [DOUBLE])
    do
      result_vector := result_vector_
    end


feature -- Attributes
  nelts: INTEGER
  start, final: INTEGER
  matrix: ARRAY2 [INTEGER]

feature -- Random matrix generation
  to_local_row (i: INTEGER): INTEGER
    do
      Result := i - start + 1
    end

  live_randmat
    local
      s, lcg_a, lcg_c, rand_max: NATURAL
      i, j: INTEGER
    do
      lcg_a := 1664525
      lcg_c := 1013904223
      rand_max := 100

      from i := start
      until i > final
      loop
        s := seed + i.to_natural_32 - 1
        from j := 1
        until j > nelts
        loop
          s := lcg_a * s + lcg_c
          matrix [i, j] := (s \\ rand_max).to_integer_32
          j := j + 1
        end
        i := i + 1
      end
    end

feature {NONE}
  seed: NATURAL

feature -- Thresholding computations
  live_thresh_reduce
    local
      i, j: INTEGER
      local_max: INTEGER
      hist: ARRAY [INTEGER]
      e: INTEGER
    do
      create hist.make_filled (0, 0, 100)
      local_max := 0

      from i := start
      until i > final
      loop
        from j := 1
        until j > nelts
        loop
          e        := matrix [i, j]
          hist [e] := hist [e] + 1
          local_max := e.max (local_max)

          j := j + 1
        end
        i := i + 1
      end
      update_histogram (local_max, max, hist, histogram)
    end

  update_histogram (local_max: INTEGER;
                    max_: separate ARRAY [INTEGER];
                    hist: ARRAY [INTEGER];
                    sep_hist: separate ARRAY [INTEGER])
    require
      max_.generator /= Void and sep_hist.generator /= Void
    local
      i: INTEGER
      h: INTEGER
      newmax: INTEGER
    do
      max_.put (max_ [1].max (local_max), 1)

      from i := 0
      until i > 100
      loop
      	h := sep_hist.item (i)
      	sep_hist.put (h + hist [i], i)
        i := i + 1
      end
    end

  live_thresh_map (threshold: INTEGER)
    local
      i, j: INTEGER
    do
      from i := 1
      until i > nelts
      loop
        from j := 1
        until j > nelts
        loop
          if matrix [i, j] >= threshold then
            mask [i, j] := 1
          end
          j := j + 1
        end
        i := i + 1
      end
    end

feature {NONE}
  percent: INTEGER
  mask: ARRAY2 [INTEGER]
  histogram: separate ARRAY [INTEGER]
  max: separate ARRAY [INTEGER]

feature -- Winnowing procedure

  live_winnow
    local
      vector: ARRAYED_LIST [TUPLE[INTEGER, INTEGER, INTEGER]]
      i, j: INTEGER
      count: INTEGER
    do
      create vector.make (100)

      from i := start
      until i > final
      loop
        from j := 1
        until j > nelts
        loop
          if mask [i, j] = 1 then
            vector.extend ([matrix [i, j], i, j])
          end
          j := j + 1
        end
        i := i + 1
      end

      put_vectors (vector, vs, xs, ys)
    end

  put_vectors (a_vector: ARRAYED_LIST [TUPLE[v,x,y: INTEGER]];
               vs_, xs_, ys_: separate ARRAY [INTEGER])
    local
      i: INTEGER
      n: INTEGER
      t: TUPLE [v,x,y: INTEGER]
    do
      n := vs_.count
      from i := 1
      until i > a_vector.count
      loop
        t := a_vector [i]
        vs_ [n + i] := t.v
        xs_ [n + i] := t.x
        ys_ [n + i] := t.y
        i := i + 1
      end
    end

feature {NONE} -- Winnow attributes
  winnow_nelts: INTEGER
  win_start, win_final: INTEGER
  vs, xs, ys: separate ARRAY [INTEGER]
  winnow_xs, winnow_ys: separate ARRAY [INTEGER]

feature -- Outer procedure
  live_outer
    do
      live_outer_sep (fetch_vector (winnow_xs, winnow_ys))
    end

  live_outer_sep (a_points: ARRAY[TUPLE[x,y: INTEGER]])
    local
      nmax: DOUBLE
      d: DOUBLE
      p1, p2: TUPLE [x,y : INTEGER]
      i, j: INTEGER
      l_vector: ARRAY [DOUBLE]
    do
      create outer_matrix.make (to_local_win_row (win_final), winnow_nelts)
      create l_vector.make (win_start, win_final)

      from i := win_start
      until i > win_final
      loop
        nmax := -1
        p1 := a_points [i]
        from j := 1
        until j > winnow_nelts
        loop
          if i /= j then
            p2 := a_points [j]
            d := distance (p1, p2)
            outer_matrix [to_local_win_row (i), j] := d
            nmax := nmax.max (d)
          end
          j := j + 1
        end
        outer_matrix [to_local_win_row (i), i] := nmax * nelts
        l_vector [i] := distance ([0,0], a_points [i])
        i := i + 1
      end
      share_vector (l_vector, shared_vector)
    end

feature {NONE} -- Outer attributes
  outer_matrix: ARRAY2 [DOUBLE]
  outer_xs, outer_ys: separate ARRAY [INTEGER]

  to_local_win_row (i: INTEGER): INTEGER
    do
      Result := i - win_start + 1
    end


  distance(a, b: TUPLE[x,y: INTEGER]): DOUBLE
    do
      Result := {DOUBLE_MATH}.sqrt(sqr(a.x - b.x) + sqr(a.y - b.y));
    end

  sqr(a: DOUBLE): DOUBLE
    do
      Result := a * a
    end


  fetch_vector (xs_, ys_: separate ARRAY[INTEGER]):
      ARRAY [TUPLE[INTEGER, INTEGER]]
    local
      i: INTEGER
      x, y: INTEGER
    do
      create Result.make (1, winnow_nelts)

      from i := 1
      until i > winnow_nelts
      loop
        x := xs_ [i]
        y := ys_ [i]
        Result [i] := [x, y]
        i := i + 1
      end
    end

  share_matrix (mat: ARRAY2[DOUBLE]; smat: separate ARRAY2[DOUBLE])
    require
      smat.generator /= Void
    local
      i, j: INTEGER
    do
      from i := win_start
      until i > win_final
      loop
        from j := 1
        until j > winnow_nelts
        loop
          smat [i, j] := mat [to_local_row (i), j]
          j := j + 1
        end
        i := i + 1
      end
    end


  share_vector (vector_: ARRAY [DOUBLE]
               ;shared_vector_: separate ARRAY [DOUBLE])
    local
      i: INTEGER
    do
      from i := 1
      until i > winnow_nelts
      loop
        shared_vector_[i] := vector_[i]
        i := i + 1
      end
    end

feature -- Product procedure
  live_product
    do
      product (import_vector (shared_vector))
    end

  product (a_vector: ARRAY [DOUBLE])
    local
      i, j: INTEGER
      sum: DOUBLE
      res: ARRAY [DOUBLE]
    do
      create res.make_filled (0, 1, final - start + 1)

      from i := win_start
      until i > win_final
      loop
        sum := 0
        from j := 1
        until j > nelts
        loop
          sum := sum + outer_matrix [to_local_win_row (i), j] * a_vector [j]
          j := j + 1
        end
        res [to_local_win_row (i)] := sum
        i := i + 1
      end

      export_vector (res, result_vector)
    end

feature {NONE}
  shared_vector, result_vector: separate ARRAY [DOUBLE]

  import_vector (shared_vector_: separate ARRAY [DOUBLE]): ARRAY [DOUBLE]
    local
      i: INTEGER
    do
      create Result.make (1, winnow_nelts)
      from i := 1
      until i > winnow_nelts
      loop
        Result [i] := shared_vector_ [i]
        i := i + 1
      end
    end

  export_vector (vector_: ARRAY [DOUBLE]
                ;shared_vector_: separate ARRAY [DOUBLE])
    local
      i: INTEGER
    do
      from i := win_start
      until i > win_final
      loop
        shared_vector_ [i] := vector_ [i]
        i := i + 1
      end
    end


end

