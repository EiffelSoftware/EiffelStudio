	-- randmat: random number generation
	--
	-- input:
	--   nrows, ncols: the number of rows and cols
	--   s: the seed
	--
	-- output:
	--   matrix: a nrows by ncols integer matrix
class
	MAIN

inherit

	ARGUMENTS

	EXCEPTIONS

create
	make

feature

	make
		local
			s: INTEGER
			is_bench: BOOLEAN
			i: INTEGER
			vector: ARRAY [DOUBLE]
			n_str: STRING
		do
			create in.make_open_read (separate_character_option_value ('i'))
			n_str := separate_character_option_value ('x')
			if n_str /= Void then
				num_workers := n_str.to_integer
			else
				num_workers := 32
			end

			is_bench := index_of_word_option ("bench") > 0
			nelts := read_integer
			s := read_integer
			percent := read_integer
			winnow_nelts := read_integer
			create histogram_max
			create histogram.make_filled (0, 0, 100)
			create vs.make_filled (0, 0, 20000 - 1)
			create xs.make_filled (0, 0, 20000 - 1)
			create ys.make_filled (0, 0, 20000 - 1)
			create winnow_xs.make_filled (0, 0, winnow_nelts - 1)
			create winnow_ys.make_filled (0, 0, winnow_nelts - 1)
			create shared_vector.make_filled (0, winnow_nelts)
			print ("run%N")
			run (s)
			all_done
			vector := fetch_all_vector
			if not is_bench then
				from
					i := 0
				until
					i >= winnow_nelts
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

	histogram_max: separate HISTOGRAM_MAX

	shared_vector: separate SPECIAL [DOUBLE]

	workers: LINKED_LIST [separate WORKER]

	read_integer: INTEGER
		do
			in.read_integer
			Result := in.last_integer
		end

	num_workers: INTEGER

		-- parallel for on matrix

	run (seed: INTEGER)
		local
			worker: separate WORKER
			i: INTEGER
			win_start, start: INTEGER
			win_height, height: INTEGER
		do
			create workers.make
			from
				start := 0
				i := 0
			until
				i >= num_workers
			loop
				height := (nelts - start) // (num_workers - i)
				win_height := (winnow_nelts - win_start) // (num_workers - i)
				if height /= 0 then
					print ("create " + start.out + "," + height.out + "%N")
					create worker.make (start, start + height, nelts, seed, percent, win_start, win_start + win_height, winnow_nelts)
					worker_setup (worker)
					workers.extend (worker)
				end
				start := start + height
				win_start := win_start + win_height
				i := i + 1
			end

				-- parallel for on rows
			live_all
		end

	worker_setup (worker: separate WORKER)
		do
			worker.set_histogram_max (histogram_max)
			worker.set_histogram (histogram)
			worker.set_vs (vs)
			worker.set_xs (xs)
			worker.set_ys (ys)
			worker.set_winnow_xs (winnow_xs)
			worker.set_winnow_ys (winnow_ys)
		end

	live_all
		do
			print ("randmat%N")
				-- Randmat creation
			from
				workers.start
			until
				workers.after
			loop
				live_randmat (workers.item)
				workers.forth
			end
			print ("threshold%N")
				-- Threshold discovery
			from
				workers.start
			until
				workers.after
			loop
				live_thresh_reduce (workers.item)
				workers.forth
			end

			print ("waiting on histogram count%N")
			histogram_done (histogram_max)
			print ("done waiting on histogram count%N")
			process_histogram (histogram_max, histogram)

			print ("threshmap%N")
			from
				workers.start
			until
				workers.after
			loop
				live_thresh_map (workers.item)
				workers.forth
			end
			print ("winnow%N")
				-- Winnow point collection and sorting
			from
				workers.start
			until
				workers.after
			loop
				live_winnow (workers.item)
				workers.forth
			end

  		sort_winnow (import_winnow, winnow_xs, winnow_ys)
			print ("outer%N")
				-- Outer processing
			from
				workers.start
			until
				workers.after
			loop
				live_outer (workers.item)
				workers.forth
			end
			print ("product%N")
				-- Matrix-vector product
			from
				workers.start
			until
				workers.after
			loop
				live_product (workers.item)
				workers.forth
			end
		end

	histogram_done(h: separate HISTOGRAM_MAX)
		require
			h.done = workers.count
		do
			print ("workers is ")
			print (workers.count)
			print (" and cell is ")
			print (h.done)
			print ("%N")
		end

	process_histogram (a_max: separate HISTOGRAM_MAX; a_histogram: separate ARRAY [INTEGER])
		local
			count: INTEGER
			nmax: INTEGER
			prefixsum: INTEGER
			i: INTEGER
			h: INTEGER
		do
			nmax := a_max.max
			count := (nelts * nelts * percent) // 100
			prefixsum := 0
			threshold := nmax

			print ("nmax :")
			print (nmax)
			print ("%N")

			print ("histogram count: ")
			print (count)
			print ("%N")
			from
				i := nmax
			until
				i < 0 or prefixsum > count
			loop
				h := a_histogram [i]
				print ("histogram[" + i.out + "] = " + h.out + "%N")
				prefixsum := prefixsum + h
				threshold := i;
				i := i - 1
			end
		end

	import_winnow: ARRAYED_LIST [TUPLE [INTEGER, INTEGER, INTEGER]]
		do
			print ("Master: importing winnow%N")
			create Result.make (10000)

			across
				workers as wi
			loop
				import_winnow_worker (Result, wi.item)
			end
		end

	import_winnow_worker (vector: ARRAYED_LIST [TUPLE [v, x, y: INTEGER]]; w: separate WORKER)
		local
			i: INTEGER
			v,x,y: INTEGER
		do
			print ("import winnow from worker: " + w.winnow_vector_v.count.out + "%N")
			vector.grow (vector.count + w.winnow_vector_v.count)
			from
				i := 0
			until
				i >= w.winnow_vector_v.count
			loop
				v := w.winnow_vector_v[i+1]
				x := w.winnow_vector_x[i+1]
				y := w.winnow_vector_y[i+1]
				vector.extend ([v, x, y])
				i := i + 1
			end
		end

	sort_winnow (points: ARRAYED_LIST [TUPLE [x, y, z: INTEGER]] winnow_xs_, winnow_ys_: separate ARRAY [INTEGER])
		local
			sorter: SORTER [TUPLE [INTEGER, INTEGER, INTEGER]] -- TUPLE_SORTER

			i, n, chunk, index: INTEGER
		do
			print ("Master: sorting winnow " + points.count.out + "%N")
			create {QUICK_SORTER [TUPLE [INTEGER, INTEGER, INTEGER]]} sorter.make (create {TUPLE_COMPARATOR})
			sorter.sort (points)

			n := points.count
			chunk := n // winnow_nelts

				--      create points.make_filled ([0,0,0], 0, winnow_nelts-1)
			from
				i := 0
			until
				i >= winnow_nelts
			loop
				index := i * chunk + 1
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
    require

		do
			worker.live_winnow
		end

	live_outer (worker: separate WORKER)
		do
			worker.live_outer (shared_vector)
		end

	live_product (worker: separate WORKER)
		do
			worker.live_product
		end

	all_done
		do
			across workers as wi
       	loop
				check_done (wi.item)
		   end
		end

	check_done (worker: separate WORKER)
		require
			worker.done
		do
		end

	fetch_all_vector: ARRAY [DOUBLE]
		do
			create Result.make_filled (0, 0, winnow_nelts - 1)
			across workers as wi
			loop
				print ("Fetching vector%N")
				fetch_vector (Result, wi.item)
		   end
		end

	fetch_vector(res: ARRAY [DOUBLE]; w: separate WORKER)
		local
			i, s, n: INTEGER
		do
		  n := w.win_final
			from
				s := w.win_start
				i := s
			until
				i >= n
			loop
				res [i] := w.product_vector [i - s]
				i := i + 1
			end
		end


end
