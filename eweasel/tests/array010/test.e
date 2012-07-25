class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run tests.
		local
			a: SORTABLE_ARRAY [INTEGER]
			i: INTEGER_32
			l_lower, l_upper: INTEGER
		do
			l_lower := {INTEGER_32}.max_value - 5
			l_upper := {INTEGER_32}.max_value - 1
				-- {INTEGER_32}.max_value will cause overflow, so we use {INTEGER_32}.max_value - 1
			create a.make_filled (1, l_lower, l_upper)
			from
				i := l_lower
			until
				i > l_upper
			loop
				a.put (i, i)
				i := i + 1
			end
				-- Put some values to make it unsorted.
			a.put (100, l_lower + 1)
			a.put (30, l_lower + 2)

			a.sort

			a.binary_search (100)

			if a.found_index /= l_lower + 1 then
				print ("Binary search failed%N")
			end
		end

end
