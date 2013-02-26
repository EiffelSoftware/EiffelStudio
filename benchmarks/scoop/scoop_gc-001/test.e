note
	description: "[
		Create processors without using them
		by the main root processor.
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
			s: DATE_TIME
			t: separate TEST
		do
			create a
			if a.argument_count /= 1 or else not a.argument (1).is_natural_64 then
				io.error.put_string ("Usage: test number_of_iterations")
				(create {EXCEPTIONS}).die (-1)
			end
			from
				i := a.argument (1).to_natural_64
				create s.make_now_utc
			until
				i <= 0
			loop
				i := i - 1
				create t
			end
			io.put_integer_64 ((create {DATE_TIME}.make_now_utc).relative_duration (s).seconds_count)
		end

end
