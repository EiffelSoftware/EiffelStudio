note
	description: "Stress test for processor creation and garbage collection (similar to bench001). %
				% The test is a regression test for a race condition, which usually only triggers during heavy load. %
				% You may need to start several instances of this test in parallel to trigger the bug."

class TEST

inherit
	MEMORY

create
	default_create,
	full_collect,
	make

feature {NONE} -- Creation

	bench_option: STRING_32 = "-bench"

	make
			-- Run test.
		local
			a: ARGUMENTS_32
			i: NATURAL_64
			s: DATE_TIME
			t: separate TEST
		do
			fill (data)
			create a
			if a.argument_count = 0 or else not a.argument (1).is_natural_64 then
				io.error.put_string ("Usage: test number_of_iterations [-bench]%N")
				(create {EXCEPTIONS}).die (-1)
			end
			from
				i := a.argument (1).to_natural_64
				create s.make_now_utc
			until
				i <= 0
			loop
				i := i - 1
				create t.full_collect
			end
 			if a.argument_count <= 1 or else a.argument (2) /~ bench_option then
				io.put_integer_64 ((create {DATE_TIME}.make_now_utc).relative_duration (s).seconds_count)
			end
		end

feature {NONE} -- GC data

	data: separate LINKED_LIST [detachable separate ANY]
			-- Data to make sure GC cycle takes some time.
		once ("PROCESS")
			create Result.make
		end

	fill (d: like data)
			-- Fill `d' with values.
		local
			i: like data.count
		do
			from
				i := 1_000_000
			until
				i <= 0
			loop
				d.put_front (Void)
				i := i - 1
			end
		end

end
