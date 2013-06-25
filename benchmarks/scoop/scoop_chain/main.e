-- randmat: random number generation
--
-- input:
--   nrows, ncols: the number of rows and cols
--   s: the seed
--
-- output:
--   matrix: a nrows by ncols integer matrix

class MAIN
inherit ARGUMENTS
  EXCEPTIONS
create make

feature
  make
    local
      s: INTEGER
      is_bench: BOOLEAN
      i: INTEGER
      vector: ARRAY [DOUBLE]
    do
      create in.make_open_read(separate_character_option_value('i'))
      is_bench := index_of_word_option ("bench") > 0

      nelts := read_integer
      s := read_integer
      percent := read_integer
      winnow_nelts := read_integer

      create result_vector.make (1, winnow_nelts)
      create max.make (1,1)
      create vs.make (1, 20000)
      create xs.make (1, 20000)
      create ys.make (1, 20000)
      create winnow_xs.make (1, 20000)
      create winnow_ys.make (1, 20000)

      print ("run%N")
      run (s)

      if not is_bench then
        vector := fetch_vector (result_vector)
        
        from i := 1
        until i > nelts
        loop
          print (vector [i].out + " ")
          i := i + 1
        end
        print ("%N")
      end
    end

feature {NONE}
  in: PLAIN_TEXT_FILE
  percent, threshold: INTEGER
  winnow_nelts, nelts: INTEGER


  vs, xs, ys: separate ARRAY [INTEGER]
  winnow_xs, winnow_ys: separate ARRAY [INTEGER]
  histogram: separate ARRAY [INTEGER]
  max: separate ARRAY [INTEGER]
  result_vector: separate ARRAY [DOUBLE]

 
  read_integer: INTEGER
    do
      in.read_integer
      Result := in.last_integer
    end

  num_workers: INTEGER = 32
  
  -- parallel for on matrix
  run (seed: INTEGER)
    local
      workers: LINKED_LIST[separate WORKER]
      worker: separate WORKER
      i: INTEGER
      win_start, start: INTEGER
      win_height, height: INTEGER
    do
      create workers.make

      from
        start := 0
        i := 0
      until i >= num_workers
      loop

        height := (nelts - start) // (num_workers - i)
        win_height := (winnow_nelts - win_start) // (num_workers - i)


        if height /= 0 then
          print ("create " + start.out + "," + height.out + "%N")
          create worker.make (start + 1, start + height, nelts, 
                              seed, percent, 
                              win_start + 1, win_start + win_height,
                              winnow_nelts)
                      
          worker_setup (worker)

          workers.extend(worker)
        end
          
        start := start + height
        win_start := win_start + win_height
        i := i + 1
      end

      -- parallel for on rows
      live_all (workers)
    end

  worker_setup (worker: separate WORKER)
    do
      worker.set_max (max)
      worker.set_histogram (histogram)
      worker.set_vs (vs)
      worker.set_xs (xs)
      worker.set_ys (ys)
      worker.set_winnow_xs (winnow_xs)
      worker.set_winnow_ys (winnow_ys)
      worker.set_result_vector (result_vector)
    end

  live_all (workers: LINKED_LIST [separate WORKER])
    do
      print ("randmat%N")
      -- Randmat creation
      from workers.start
      until workers.after
      loop
          live_randmat (workers.item)
          workers.forth
      end

      print ("threshold%N")
      -- Threshold discovery
      from workers.start
      until workers.after
      loop
          live_thresh_reduce (workers.item)
          workers.forth
      end

      process_histogram (max, histogram)

      print ("threshmap%N")
      from workers.start
      until workers.after
      loop
          live_thresh_map (workers.item)
          workers.forth
      end

      print ("winnow%N")
      -- Winnow point collection and sorting
      from workers.start
      until workers.after
      loop
          live_winnow (workers.item)
          workers.forth
      end

      sort_winnow (import_winnow (vs, xs, ys), winnow_xs, winnow_ys) 

      print ("outer%N")
      -- Outer processing
      from workers.start
      until workers.after
      loop
          live_outer (workers.item)
          workers.forth
      end

      print ("product%N")
      -- Matrix-vector product
      from workers.start
      until workers.after
      loop
          live_product (workers.item)
          workers.forth
      end
    end

  process_histogram (a_max: separate ARRAY [INTEGER];
                     a_histogram: separate ARRAY [INTEGER])
    require
      a_max.generator /= Void and a_histogram.generator /= Void
    local
      count: INTEGER
      nmax: INTEGER
      prefixsum: INTEGER
      i: INTEGER
      h: INTEGER
    do
      nmax := a_max.item (1)
      count := (nelts * nelts * percent) // 100

      prefixsum := 0
      threshold := nmax

      from i := nmax
      until i < 0 or prefixsum > count
      loop
      	h := a_histogram.item (i)
        prefixsum := prefixsum + h
        threshold := i;
        i := i - 1
      end
    end

  import_winnow (vs_, xs_, ys_: separate ARRAY[INTEGER]):
      ARRAY[TUPLE[INTEGER, INTEGER, INTEGER]]
    require
      xs_.generator /= Void
    local
      i: INTEGER
      n: INTEGER
      v,x,y: INTEGER
    do
      n := vs_.count
      create Result.make (1, n)
      
      from i := 1
      until i > n
      loop
        v := vs_ [i]
        x := xs_ [i]
        y := ys_ [i]
        
        Result [i] := [v, x, y]
        i := i + 1
      end
    end

  sort_winnow (points_: ARRAY [TUPLE [x,y,z: INTEGER]]
               winnow_xs_, winnow_ys_: separate ARRAY [INTEGER])
    local
      points: ARRAY [TUPLE [v,x,y: INTEGER]]
      trim_points: ARRAY [TUPLE [v,x,y: INTEGER]]

      sorter: TUPLE_SORTER

      i, n, chunk, index: INTEGER
    do
      create sorter.make
      
      points := sorter.sort (points_)

      n     := points.count
      chunk := n // winnow_nelts

      create points.make (1, winnow_nelts)
      from i := 1
      until i > winnow_nelts
      loop
        index := (i - 1) * chunk + 1
        winnow_xs_ [i] := points [index].x
        winnow_ys_ [i] := points [index].y
        i := i + 1
      end
    end

feature -- Living routines
  live_randmat (worker: separate WORKER)
    do
      worker.live_randmat
    end

  live_thresh_reduce (worker: separate WORKER)
    do
      worker.live_thresh_reduce
    end

  live_thresh_map (worker: separate WORKER)
    do
      worker.live_thresh_map (threshold)
    end

  live_winnow (worker: separate WORKER)
    do
        worker.live_winnow
    end

  live_outer (worker: separate WORKER)
    do
      worker.live_outer
    end

  live_product (worker: separate WORKER)
    do
      worker.live_product
    end

  join (obj: separate WORKER)
    require obj.generator /= Void
    do
    end
  
  fetch_vector (s_vector: separate ARRAY[DOUBLE]):
      ARRAY [DOUBLE]
    local
      i: INTEGER
    do
      create Result.make (1, nelts)
      from i := 1
      until i > winnow_nelts
      loop
        Result [i] := s_vector [i]
        i := i + 1
      end
    end

end
