class 
	TEST

create

	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		do
			indexable_iteration_cursor_cursor_index_orig
			indexable_iteration_cursor_forth_orig
		end
		
	indexable_iteration_cursor_cursor_index_orig
			-- `cursor_index' is not always positive.
		local
			array: ARRAY [INTEGER]
			cursor: INDEXABLE_ITERATION_CURSOR [INTEGER]
			i: INTEGER
		do
			create array.make_filled (0, 5, 10)
			create {READABLE_INDEXABLE_ITERATION_CURSOR [INTEGER]} cursor.make (array)
			i := cursor.cursor_index
		end

	indexable_iteration_cursor_forth_orig
			-- `cursor_index' advanced by `step' instead of by one.
			-- FIXED
		local
			array: ARRAY [INTEGER]
			cursor: READABLE_INDEXABLE_ITERATION_CURSOR [INTEGER]
		do
			create array.make_filled (0, 5, 10)
			create cursor.make (array)
			cursor.set_step (3)
			cursor.start
			cursor.forth
		end

end