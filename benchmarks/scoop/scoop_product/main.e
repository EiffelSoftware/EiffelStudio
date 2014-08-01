	-- product: matrix-vector product
	--
	-- input:
	--   matrix: a real matrix
	--   vector: a real vector
	--   nelts: the number of elements
	--
	-- output:
	--   res: a real vector, whose values are the result of the product

class
	MAIN

inherit

	ARGUMENTS

create
	make

feature

	make
		local
			nelts: INTEGER
			i: INTEGER
			res: ARRAY [REAL_64]
		do
			check attached separate_character_option_value ('i') as file_name then
				create in.make_open_read (file_name)
				is_bench := index_of_word_option ("bench") > 0
				in.read_integer
				nelts := in.last_integer
				create matrix.make_filled (0, nelts, nelts)
				create vector.make_filled (0, 1, nelts)
				create result_vector.make_filled (0, 1, nelts)
				if not is_bench then
					read_matrix (nelts, matrix)
					read_vector (nelts, vector)
				end
				res := product (nelts)
				if not is_bench then
					print (nelts.out + "%N")
					from
						i := 1
					until
						i > nelts
					loop
						print (res [i].out + " ")
						i := i + 1
					end
					print ("%N")
				end
			end
		end

	read_vector (nelts: INTEGER; a_vector: separate ARRAY [REAL_64])
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > nelts
			loop
				a_vector [i] := read_double
				i := i + 1
			end
		end

	read_matrix (nelts: INTEGER; a_matrix: separate ARRAY2 [REAL_64])
		local
			i, j: INTEGER
		do
			from
				i := 1
			until
				i > nelts
			loop
				from
					j := 1
				until
					j > nelts
				loop
					a_matrix [i, j] := read_double
					j := j + 1
				end
				i := i + 1
			end
		end

	read_double: REAL_64
		do
			in.read_double
			Result := in.last_double
		end

	num_workers: INTEGER = 32

	product (nelts: INTEGER): ARRAY [REAL_64]
		local
			worker: separate PARFOR_WORKER
			workers: LINKED_LIST [separate PARFOR_WORKER]
			start, height, i: INTEGER
		do
			create workers.make
			from
				start := 0
				i := 0
			until
				i >= num_workers
			loop
				height := (nelts - start) // (num_workers - i)
				if height > 0 then
					create worker.make (start + 1, start + height, nelts, matrix, vector, result_vector)
					workers.extend (worker)
				end
				start := start + height
				i := i + 1
			end
				-- parallel for on rows
			workers_live (workers)

				-- join workers
			workers_join (workers)
			Result := to_local (nelts, result_vector)
		end

		-- to_separate(nelts: INTEGER; vector: ARRAY[REAL_64])
		-- : separate ARRAY[REAL_64]
		--   local
		--     res: separate ARRAY[REAL_64]
		--   do
		--     create res.make_empty
		--     across 1 |..| nelts as ic loop
		--     res.force(vector.item(ic.item), ic.item);
		--   end
		-- Result := res
		--   end

	to_local (nelts: INTEGER; a_vector: separate ARRAY [REAL_64]): ARRAY [REAL_64]
		local
			i: INTEGER
		do
			create Result.make_filled (0, 1, nelts)
			from
				i := 1
			until
				i > nelts
			loop
				Result [i] := a_vector [i]
				i := i + 1
			end
		end

feature {NONE}

	workers_live (workers: LINKED_LIST [separate PARFOR_WORKER])
		do
			from
				workers.start
			until
				workers.after
			loop
				worker_live (workers.item)
				workers.forth
			end
		end

	workers_join (workers: LINKED_LIST [separate PARFOR_WORKER])
		do
			from
				workers.start
			until
				workers.after
			loop
				worker_join (workers.item)
				workers.forth
			end
		end

	worker_live (worker: separate PARFOR_WORKER)
		do
			worker.live
		end

	worker_join (worker: separate PARFOR_WORKER)
		require
			worker.generator /= Void
		do
		end

feature {NONE}

	in: PLAIN_TEXT_FILE

	is_bench: BOOLEAN

	matrix: separate ARRAY2 [REAL_64]

	vector: separate ARRAY [REAL_64]

	result_vector: separate ARRAY [REAL_64]

end -- class MAIN

