class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run tests.
		do
			array_force_orig
			array_index_set_orig
			array_remove_head_orig
		end
		
	array_force_orig
			-- When an element should be forced on the left into an empty array,
			-- it is added on the right instead.
		local
			array: ARRAY [INTEGER]
		do
			create array.make_empty
			array.force (-2, -2)
		end

	array_index_set_orig
			-- Wrong postcondition:
			-- An empty array can have arbitrary lower bound, but empty interval is always [1, 0].
		local
			array: ARRAY [INTEGER]
			index_set: INTEGER_INTERVAL
		do
			create array.make (-1, -2)
			index_set := array.index_set
		end

	array_remove_head_orig
			-- Wrong postcondition:
			-- When n > count, upper is set to lower - 1.
		local
			array: ARRAY [INTEGER]
		do
			create array.make (1, 10)
			array.remove_head (11)
		end

end
