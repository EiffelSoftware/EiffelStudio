note
	description: "[
		Create processors without using them so that
		a next processor is started by the current
		processor that is started by a previous one.
		The total number of created processors is
		higher than the maximum number of the
		processors that can be created at the
		same time.
	]"

class TEST

create
	default_create,
	make

feature {NONE} -- Creation

	make
			-- Run test.
		do
			execute (10_000)
		end

feature {TEST} -- Run

	execute (i: NATURAL_64)
			-- Start one more processor with index `i - 1' unless `i = 0'.
		do
			if i /= 0 then
				run (create {separate TEST}, i - 1)
			end
		end

	run (t: separate TEST; i: NATURAL_64)
			-- Run `t.execute (i)'.
		do
			t.execute (i)
		end

end
