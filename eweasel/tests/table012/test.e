class 
	TEST

create

	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		do
			hash_table_is_equal
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



end