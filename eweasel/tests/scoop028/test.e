note
	description: "[
		Create processors without using them
		by the main root processor so that the
		total number of created processors is
		higher than the maximum number of the
		processors that can be created at the
		same time.
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
			i: NATURAL_64
			t: separate TEST
		do
			from
				i := 10_000
			until
				i <= 0
			loop
				i := i - 1
				create t
			end
		end

end
