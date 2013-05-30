class
	TEST

inherit
	MEMORY

create
	make

feature -- Initialization

	make
			-- Run application.
		local
			l_list: ARRAYED_LIST [INTEGER]
			l_iterator: INDEXABLE_ITERATION_CURSOR [INTEGER]
			i: INTEGER
		do
			create mi.make ({MEM_INFO}.Eiffel_memory)
			create l_list.make (1000000)
			from
				i := 1
			until
				i = 1000000
			loop
				l_list.extend (i)
				i := i + 1
			end

			l_iterator := l_list.new_cursor
			check_memory
			across l_iterator as l_c loop
				l_c.item.do_nothing
			end
			check_memory
		end

	check_memory
		local
			u64: NATURAL_64
		do
			if first_used_memory = 0 then
				collect
				full_collect
				full_coalesce

				mi.update ({MEM_INFO}.Eiffel_memory)
				u64 := mi.used64
				first_used_memory := u64
				collection_off
			else
				mi.update ({MEM_INFO}.Eiffel_memory)
				u64 := mi.used64
				if u64 /= first_used_memory then
					io.put_string ("Found leak: (curr - prev = ")
					print_diff (u64, first_used_memory)
					io.put_string (")%N")
				end
			end
		end

	print_diff (u1, u2: NATURAL_64)
		local
			r: NATURAL_64
		do
			if u1 >= u2 then
				r := u1 - u2
			else
				r := u2 - u1
				io.put_character ('-')
			end
			io.put_natural_64 (r)
		end

feature {NONE} -- Implementation

	first_used_memory: NATURAL_64

	mi: MEM_INFO

end
