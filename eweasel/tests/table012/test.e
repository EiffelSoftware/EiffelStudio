class 
	TEST

create

	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		do
			hash_table_is_equal
			hash_table_iteration_item
			hash_table_valid_iteration_index_orig
		end
		
	hash_table_is_equal
			-- Unlike other containers, does not compare `object_comparison'.
			-- (There is another problem with is_equal: it takes the order of insertions into account,
			-- but random testing does not find this).
		local
			table1, table2: HASH_TABLE [INTEGER, STRING]
		do
			create table1.make (10)
			create table2.make (10)
			table1.compare_objects
			check not table1.is_equal (table2) end
		end

	hash_table_iteration_item
			-- Precondition `valid_iteration_index' of `iteration_item' accepts indexes that are off.
			-- FIXED
		local
			table: HASH_TABLE [INTEGER, STRING]
			v: INTEGER
		do
			create table.make (10)
			v := table.iteration_item (1)
		end
		
	hash_table_valid_iteration_index_orig
			-- Postcondition disallows off position, while implementation allows it.
			-- FIXED
		local
			table: HASH_TABLE [INTEGER, STRING]
			b: BOOLEAN
		do
			create table.make (10)
			b := table.valid_iteration_index (1)
		end

end