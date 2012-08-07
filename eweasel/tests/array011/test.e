class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run tests.
		do
			array_force_2
		end
		
	array_force_2
			-- Array size > 1 after forcing a single element into an enpty array
			-- (because upper bound considered to be 0 in an empty array).
		local
			array: ARRAY [INTEGER]
		do
			create array.make_empty
			array.force (10, 10)
			check array.count = 1 end
		end

end
