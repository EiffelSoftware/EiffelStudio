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

      create matrix.make_filled (0, (final-start) * nelts)
      create mask.make_filled (0, (final-start) * nelts)
    end

feature -- Setters
  set_histogram_max (max_ : separate HISTOGRAM_MAX)
    do
      histogram_max := max_
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


feature -- Attributes
  nelts: INTEGER
  start, final: INTEGER
  matrix: SPECIAL [INTEGER]

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
      until i >= final
      loop
        s := seed + i.to_natural_32
        from j := 0
        until j >= nelts
        loop
          s := lcg_a * s + lcg_c
          matrix [(i - start) * nelts + j] := (s \\ rand_max).to_integer_32
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
      until i >= final
      loop
        from j := 0
        until j >= nelts
        loop
          e        := matrix [(i - start) * nelts + j]
          hist [e] := hist [e] + 1
          local_max := e.max (local_max)

          j := j + 1
        end
        i := i + 1
      end
      update_histogram (local_max, histogram_max, hist, histogram)
    end

  update_histogram (local_max: INTEGER;
                    max_: separate HISTOGRAM_MAX;
                    hist: ARRAY [INTEGER];
                    sep_hist: separate ARRAY [INTEGER])
    local
      i: INTEGER
      h: INTEGER
    do
      print ("Updating histogram%N")
      max_.new_max (local_max)

      from i := 0
      until i > 100
      loop
      	h := sep_hist.item (i)
      	sep_hist.put (h + hist [i], i)
        i := i + 1
      end

	   print ("finished updating histogram%N")
    end

  live_thresh_map (threshold: INTEGER)
    local
      i, j: INTEGER
    do
      from i := start
      until i >= final
      loop
        from j := 0
        until j >= nelts
        loop
          if matrix [(i - start) * nelts + j] >= threshold then
            mask [(i - start) * nelts + j] := 1
          end
          j := j + 1
        end
        i := i + 1
      end
    end

feature {NONE}
  percent: INTEGER
  mask: SPECIAL [INTEGER]
  histogram: separate ARRAY [INTEGER]
  histogram_max: separate HISTOGRAM_MAX

feature -- Winnowing procedure
  winnow_vector_v: ARRAYED_LIST [INTEGER]
  winnow_vector_x: ARRAYED_LIST [INTEGER]
  winnow_vector_y: ARRAYED_LIST [INTEGER]

  live_winnow
    local
      i, j: INTEGER
    do
      print ("Worker: live_winnow%N")
      create winnow_vector_v.make (100)
      create winnow_vector_x.make (100)
      create winnow_vector_y.make (100)


      from i := start
      until i >= final
      loop
        from j := 0
        until j >= nelts
        loop
          if mask [(i - start) * nelts + j] = 1 then
            winnow_vector_v.extend (matrix [(i - start) * nelts + j])
            winnow_vector_x.extend (i)
            winnow_vector_y.extend (j)
          end
          j := j + 1
        end
        i := i + 1
      end
      -- put_vectors (vector, vs, xs, ys)
    end

  put_vectors (a_vector: ARRAYED_LIST [TUPLE[v,x,y: INTEGER]];
               vs_, xs_, ys_: separate ARRAY [INTEGER])
    local
      i: INTEGER
      n: INTEGER
      t: TUPLE [v,x,y: INTEGER]
    do
      n := vs_.count

		vs_.grow (vs_.count + a_vector.count)
		xs_.grow (xs_.count + a_vector.count)
		ys_.grow (ys_.count + a_vector.count)

      from i := 0
      until i >= a_vector.count
      loop
        t := a_vector [i + 1]
        vs_.force (t.v, n + i)
        xs_.force (t.x, n + i)
        ys_.force (t.y, n + i)
        i := i + 1
      end
    end
  win_start, win_final: INTEGER
feature {NONE} -- Winnow attributes
  winnow_nelts: INTEGER
  vs, xs, ys: separate ARRAY [INTEGER]
  winnow_xs, winnow_ys: separate ARRAY [INTEGER]

feature -- Outer procedure
  live_outer (a_shared_vector: separate SPECIAL[DOUBLE])
    do
      shared_vector := a_shared_vector
		print ("live outer%N")
      live_outer_sep (fetch_vector (winnow_xs, winnow_ys))
		print ("live outer (post fetch)%N")
    end

  live_outer_sep (a_points: ARRAY[TUPLE[x,y: INTEGER]])
    local
      nmax: DOUBLE
      d: DOUBLE
      p1, p2: TUPLE [x,y : INTEGER]
      i, j: INTEGER
      l_vector: ARRAY [DOUBLE]
    do
      print ("Worker: start live_outer%N")
      create outer_matrix.make_filled (0, (win_final - win_start) * winnow_nelts)
      create l_vector.make_filled (0.0, win_start, win_final - 1)

      from i := win_start
      until i >= win_final
      loop
        nmax := -1
        p1 := a_points [i]
        from j := 0
        until j >= winnow_nelts
        loop
          if i /= j then
            p2 := a_points [j]
            d := distance (p1, p2)
            outer_matrix [(i - win_start) * winnow_nelts + j] := d
            nmax := nmax.max (d)
          end
          j := j + 1
        end
        outer_matrix [(i - win_start) * winnow_nelts + i] := nmax * winnow_nelts
        l_vector [i] := distance ([0,0], a_points [i])
        i := i + 1
      end
      share_vector (l_vector, shared_vector)
    end

feature {NONE} -- Outer attributes
  outer_matrix: SPECIAL [DOUBLE]
  outer_xs, outer_ys: separate ARRAY [INTEGER]

  to_local_win_row (i: INTEGER): INTEGER
    do
      Result := i - win_start
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
      create Result.make_filled ([0,0], 0, winnow_nelts - 1)

      from i := 0
      until i >= winnow_nelts
      loop
        x := xs_ [i]
        y := ys_ [i]
        Result [i] := [x, y]
        i := i + 1
      end
    end

  share_matrix (mat: SPECIAL[DOUBLE]; smat: separate SPECIAL [DOUBLE])
    local
      i, j: INTEGER
    do
      from i := win_start
      until i >= win_final
      loop
        from j := 0
        until j >= winnow_nelts
        loop
          smat [i * winnow_nelts + j] := mat [(i - win_start) * winnow_nelts + j]
          print (mat[(i - win_start) * winnow_nelts + j])
          print (" ")

          j := j + 1
        end
        print ("%N")
        i := i + 1
      end
    end


  share_vector (vector_: SPECIAL [DOUBLE]
               ;shared_vector_: separate SPECIAL [DOUBLE])
    local
      i: INTEGER
    do
      from i := win_start
      until i >= win_final
      loop
        shared_vector_[i] := vector_[i - win_start]
        i := i + 1
      end
    end

feature -- Product procedure
	done: BOOLEAN
	product_vector: ARRAY [DOUBLE]

	live_product
    do
		 print ("live product%N")
		 product (import_vector (shared_vector))
		 done := True
    end

  product (a_vector: ARRAY [DOUBLE])
    local
      i, j: INTEGER
      sum: DOUBLE
    do
      create product_vector.make_filled (0, 0, win_final - win_start - 1)
		print ("live product (post import)%N")

      from i := win_start
      until i >= win_final
      loop
        sum := 0
        from j := 0
        until j >= winnow_nelts
        loop
          sum := sum + outer_matrix [(i - win_start) * winnow_nelts + j] * a_vector [j]
          j := j + 1
        end
        product_vector [i - win_start] := sum
        i := i + 1
      end
      print ("live product done%N")
    end

feature {NONE}
  shared_vector: separate SPECIAL [DOUBLE]

  import_vector (shared_vector_: separate SPECIAL [DOUBLE]): ARRAY [DOUBLE]
    local
      i: INTEGER
    do
      create Result.make_filled (0, 0, winnow_nelts - 1)
      from i := 0
      until i >= winnow_nelts
      loop
        Result [i] := shared_vector_ [i]
        i := i + 1
      end
    end

  export_vector (vector_: SPECIAL [DOUBLE]
                ;shared_vector_: separate SPECIAL [DOUBLE])
    local
      i: INTEGER
    do
      from i := win_start
      until i >= win_final
      loop
        shared_vector_ [i] := vector_ [i]
        i := i + 1
      end
    end


end

