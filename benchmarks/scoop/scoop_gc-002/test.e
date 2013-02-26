note
	description: "[
		Create processors without using them
		so that a next processor is started by the current processor
		that is started by a previous one.
	]"

class TEST

inherit
	ANY

create
	default_create,
	make

feature {NONE} -- Creation

	make
			-- Run test.
		local
			a: ARGUMENTS_32
			i: NATURAL_64
			s: like {DATE_TIME_DURATION}.seconds_count
		do
			create a
			if a.argument_count /= 1 or else not a.argument (1).is_natural_64 then
				io.error.put_string ("Usage: test number_of_iterations")
				(create {EXCEPTIONS}).die (-1)
			end
			i := a.argument (1).to_natural_64
			s := (create {DATE_TIME}.make_now_utc).relative_duration (create {DATE_TIME}.make_from_epoch (0)).seconds_count
			execute (i, s)
		end

feature {TEST} -- Run

	execute (i: NATURAL_64; s: like {DATE_TIME_DURATION}.seconds_count)
			-- Start one more processor unless `i = 0' with the overall start time `s'.
		do
			if i = 0 then
				io.put_integer_64 ((create {DATE_TIME}.make_now_utc).relative_duration (create {DATE_TIME}.make_from_epoch (s.to_integer_32)).seconds_count)
			else
				run (create {separate TEST}, i - 1, s)
			end
		end

	run (t: separate TEST; i: NATURAL_64; s: like {DATE_TIME_DURATION}.seconds_count)
			-- Run `t.execute'.
		do
			t.execute (i, s)
		end

end
