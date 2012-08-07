class 
	TEST

create

	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		do
			interger_interval_extend
			interger_interval_resize
			interger_interval_resize_exactly
			integer_interval_extend_orig
		end
		
	interger_interval_extend
			-- When an empty interval is extended with a single element, its count can be > 1
			-- (because the "fake" bounds [1, 0] are taken into account).
			-- Note: there is also a postcondition violation here,
			-- but this postcondition is wrong in general (see `interger_interval_extend_orig').
		local
			interval: INTEGER_INTERVAL
		do
			create interval.make (1, 0)
			check interval.count = 0 end
			interval.extend (10)
			check interval.count = 1 end
		end

	interger_interval_resize
			-- When an empty interval is resized, its count can be bigger than expected
			-- (because the "fake" bounds [1, 0] are taken into account).
		local
			interval: INTEGER_INTERVAL
		do
			create interval.make (1, 0)
			check interval.count = 0 end
			interval.resize (6, 10)
			check interval.count = 5 end
		end

	interger_interval_resize_exactly
			-- `resize_exactly' does not have any precondition on the bounds;
			-- As a result not only we can get an empty interval with bounds different from [1, 0]
			-- (if that's ok, then why does `make' enforce it?)
			-- but also get an interval with lower - upper > 1 and negative count.
		local
			interval: INTEGER_INTERVAL
		do
			create interval.make (1, 10)
			interval.resize_exactly (1, -50)
			check interval.count >= 0 end
		end
		
	integer_interval_extend_orig
			-- `count' can grow by more than 1.
		local
			interval: INTEGER_INTERVAL
		do
			create interval.make (1, 10)
			interval.extend (20)
		end

end