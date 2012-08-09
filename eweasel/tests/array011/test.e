class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run tests.
		do
			array_force_1
			array_force_2
			array_force_3
		end
		
	array_force_1
			-- Precondition of area.move_data violated
			-- when forcing an element on the left into a non-empty array.
			-- FIXED
		local
			array: ARRAY [INTEGER]
		do
			create array.make_filled (0, 1, 10)
			array.force (1, -10)
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
		
	array_force_3
			-- Not all new elements initialized with default value
			-- (off by one error)
			-- FIXED
		local
			array: ARRAY [INTEGER]
		do
			create array.make_filled (0, 1, 3)
			array [1] := 1
			array [2] := 2
			array [3] := 3
			array.force (-2, -2)
			check array [0] = 0 end
		end

end
