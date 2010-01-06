class
	APPLICATION

inherit
	THREAD_CONTROL

	MEMORY

create
	make

feature -- Initialization

	make (args: ARRAY [STRING]) is
			-- Run application.
		local
			i, l_count: INTEGER
		do
			l_count := args.item (1).to_integer
			from
				i := 0
			until
				i = l_count
			loop
				launch_threads (1)
				check_memory
				i := i + 1
			end
		end

	launch_threads (n: INTEGER) is
		local
			th: THREAD_FOO
			i: INTEGER
		do
			from
				i := 1
			until
				i > n
			loop
				create th
				th.launch
				i := i + 1
			end
			join_all
		end

	check_memory is
		local
			mi: MEM_INFO
			u64: NATURAL_64
		do
			collect
			full_collect
			full_coalesce

			create mi.make ({MEM_INFO}.C_memory)
			u64 := mi.used64
			mi := Void

			if first_used_memory = 0 then
				first_used_memory := u64
			end

			--( C memory)--
			if last_used_memory > 0 then
				if u64 /=  last_used_memory then
					io.put_string ("Found leak: (curr - prev=")
					print_diff (u64, last_used_memory)
					io.put_string (")")

					io.put_string (" (curr - first=")
					print_diff (u64, first_used_memory)
					io.put_string (")")
					io.put_new_line
				end
			end
			last_used_memory := u64
		end

	print_diff (u1, u2: NATURAL_64) is
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
	last_used_memory: NATURAL_64

end -- class APPLICATION
