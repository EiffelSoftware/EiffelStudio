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
      nrows, s: INTEGER
      is_bench: BOOLEAN
      i, j: INTEGER
      workers: LINKED_LIST[separate RANDMAT_PARFOR_WORKER]
    do
      create in.make_open_read(separate_character_option_value('i'))
      is_bench := index_of_word_option ("bench") > 0

      nrows := read_integer
      ncols := read_integer
      s := read_integer

      create matrix.make (nrows,ncols)
      workers := randmat(nrows, s)

      fetch_workers (workers)
      join_workers (workers)

      if not is_bench then
        from i := 1
        until i > nrows
        loop
          from j := 1
          until j > ncols
          loop
            print (matrix [i,j].out + " ")
            j := j + 1
          end
          
          print ("%N")
          i := i + 1
        end
      end
    end

  ncols: INTEGER
  matrix: ARRAY2[INTEGER]
  
  read_integer(): INTEGER
    do
      in.read_integer
      Result := in.last_integer
    end

  num_workers: INTEGER = 32
  
  -- parallel for on matrix
  randmat(nrows, seed: INTEGER):
    LINKED_LIST[separate RANDMAT_PARFOR_WORKER]
    local
      worker: separate RANDMAT_PARFOR_WORKER
      i: INTEGER
      start: INTEGER
      height: INTEGER
    do
      create Result.make

      from
        start := 0
        i := 0
      until i >= num_workers
      loop
        height := (nrows - start) // (num_workers - i)

        if height /= 0 then
          create worker.make (start + 1, height, ncols, seed)
          Result.extend(worker)
        end
          
        start := start + height
        i := i + 1
      end

      -- parallel for on rows
      live_workers (Result)
    end
  live_workers (workers: LIST [separate RANDMAT_PARFOR_WORKER])
    do
      across workers as wc loop
        live_worker (wc.item)
      end
    end
 
  fetch_workers (workers: LIST [separate RANDMAT_PARFOR_WORKER])
    do
      across workers as wc loop
        fetch_submatrix (wc.item)
      end
    end
 
  join_workers (workers: LIST [separate RANDMAT_PARFOR_WORKER])
    do
      across workers as wc loop
        join (wc.item)
      end
    end
  
  join (obj: separate RANDMAT_PARFOR_WORKER)
    require obj.generator /= Void
    do
    end
  
  fetch_submatrix (worker: separate RANDMAT_PARFOR_WORKER)
    local
      i, j: INTEGER
      iend: INTEGER
    do
      from
        i := worker.start
        iend := i + worker.height
      until i >= iend
      loop
        from j := 1
        until j > ncols
        loop
          matrix [i,j] := worker.get (i, j)
          j := j + 1
        end
        i := i + 1
      end
    end
  

  live_worker(worker: separate RANDMAT_PARFOR_WORKER)
    do
      worker.live
    end

feature {NONE}
  in: PLAIN_TEXT_FILE

end
