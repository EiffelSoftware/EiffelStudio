class RANDMAT_PARFOR_WORKER
  
create make

feature
  make (a_start, a_height, a_ncols, a_seed: INTEGER)
    do
      start := a_start
      height := a_height
      ncols := a_ncols
      seed := a_seed.to_natural_32

      create matrix.make (height, ncols)
    end

  
feature
  live
    do
      fill_matrix
    end
  
  fill_matrix
    local
      s, lcg_a, lcg_c, rand_max: NATURAL
      i, j: INTEGER
    do
      lcg_a := 1664525
      lcg_c := 1013904223
      rand_max := 100

      from i := start
      until i >= start + height
      loop
        s := seed + i.to_natural_32 - 1
        from j := 1
        until j > ncols
        loop
          s := lcg_a * s + lcg_c
          matrix [i - start + 1, j] := (s \\ rand_max).to_integer_32
          j := j + 1
        end
        i := i + 1
      end
    end

  get (i, j: INTEGER): INTEGER
    do
      Result := matrix [i - start  + 1, j]
    end
  
  matrix: ARRAY2 [INTEGER]
  height: INTEGER
  start: INTEGER
  
feature {NONE}
  seed: NATURAL
  ncols: INTEGER
  
end
