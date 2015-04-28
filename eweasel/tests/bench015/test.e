class TEST

inherit
	MEMORY
	EXECUTION_ENVIRONMENT

create
	make

feature {NONE} -- Creation

	make
		local
			i: INTEGER
			l_time1, l_time2: TIME
			l_strings: ARRAYED_LIST [STRING]
			l_count: INTEGER
			l_size: INTEGER
			l_incr: INTEGER
			a: ARGUMENTS_32
		do
			create a
			if a.argument_count /= 1 or else not a.argument (1).is_integer_32 then
				io.error.put_string ("Usage: test [1|2]")
				io.error.put_string ("Use 1 to resize each of 100,000 STRINGs.%N")
				io.error.put_string ("Use 2 to resize every other STRING.%N")
				io.error.put_new_line;
				(create {EXCEPTIONS}).die (-1)
			else
				l_incr := a.argument (1).to_integer_32

				l_size := 4096
				l_count := 100000

					-- Time creation of strings.
				from
					create l_time1.make_now
					i := 1
					create l_strings.make (l_count)
				until
					i > l_count
				loop
					l_strings.extend (create {STRING}.make (l_size))
					i := i + 1
				end

				create l_time2.make_now
				io.put_string (l_time2.relative_duration (l_time1).fine_seconds_count.out + " seconds%N")
				io.put_string ((create {GC_INFO}.make ({MEM_CONST}.Full_collector)).cycle_count.out + " full GC count%N")

					-- Resize strings by just a bit.
				l_size := l_size + 16

				from
					i := 1
					create l_time1.make_now
				until
					i > l_count
				loop
					l_strings[i].resize (l_size)
					if i \\ 10000 = 1 then
						full_collect	-- A few GC cycles are needed to populate the free list.
					end
					i := i + l_incr
				end

				create l_time2.make_now
				print (l_time2.relative_duration (l_time1).fine_seconds_count.out + " seconds%N")
				print ((create {GC_INFO}.make ({MEM_CONST}.Full_collector)).cycle_count.out + " full GC count%N")
			end
		end

end
