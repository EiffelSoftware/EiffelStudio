class TEST

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		local
			index: INTEGER
		do
			if argument_count >= 1 and then argument (1).is_integer then
				index := argument (1).to_integer

				inspect index
				when 1 then
					test_arguments (Current)
					test_arguments (argument_array)
					test_iterable (new_linked_list)
					test_iterable (new_arrayed_list)
					test_iterable (new_two_way_list)
					test_iterable (new_hash_table)
					test_iterable (new_array)
					test_iterable ("1234567")

				when 2 then
					test_indexable_reversed (new_linked_list)
					test_indexable_reversed (new_arrayed_list)
					test_indexable_reversed (new_two_way_list)
					test_indexable_reversed (new_hash_table)
					test_indexable_reversed (new_array)
					test_indexable_reversed ("1234567")

				when 3 then
					test_indexable_with_step (new_linked_list, 2)
					test_indexable_with_step (new_arrayed_list, 2)
					test_indexable_with_step (new_two_way_list, 2)
					test_indexable_with_step (new_hash_table, 2)
					test_indexable_with_step (new_array, 2)
					test_indexable_with_step ("1234567", 2)

				when 4 then
					test_indexable_with_step (new_linked_list, 4)
					test_indexable_with_step (new_arrayed_list, 4)
					test_indexable_with_step (new_two_way_list, 4)
					test_indexable_with_step (new_hash_table, 4)
					test_indexable_with_step (new_array, 4)
					test_indexable_with_step ("1234567", 4)

				when 5 then
					test_indexable_reversed_with_step (new_linked_list, 2)
					test_indexable_reversed_with_step (new_arrayed_list, 2)
					test_indexable_reversed_with_step (new_two_way_list, 2)
					test_indexable_reversed_with_step (new_hash_table, 2)
					test_indexable_reversed_with_step (new_array, 2)
					test_indexable_reversed_with_step ("1234567", 2)

				when 6 then
					test_indexable_reversed_with_step (new_linked_list, 4)
					test_indexable_reversed_with_step (new_arrayed_list, 4)
					test_indexable_reversed_with_step (new_two_way_list, 4)
					test_indexable_reversed_with_step (new_hash_table, 4)
					test_indexable_reversed_with_step (new_array, 4)
					test_indexable_reversed_with_step ("1234567", 4)

				when 7 then
					test_indexable_incremented_decremented (new_linked_list)
					test_indexable_incremented_decremented (new_arrayed_list)
					test_indexable_incremented_decremented (new_two_way_list)
					test_indexable_incremented_decremented (new_hash_table)
					test_indexable_incremented_decremented (new_array)
					test_indexable_incremented_decremented ("1234567")

				when 8 then
					test_iterable (new_empty_linked_list)
					test_iterable (new_empty_arrayed_list)
					test_iterable (new_empty_two_way_list)
					test_iterable (new_empty_hash_table)
					test_iterable (new_empty_array)
					test_iterable ("")

				when 9 then
					test_indexable_reversed (new_empty_linked_list)
					test_indexable_reversed (new_empty_arrayed_list)
					test_indexable_reversed (new_empty_two_way_list)
					test_indexable_reversed (new_empty_hash_table)
					test_indexable_reversed (new_empty_array)
					test_indexable_reversed ("")

				when 10 then
					test_indexable_with_step (new_empty_linked_list, 2)
					test_indexable_with_step (new_empty_arrayed_list, 2)
					test_indexable_with_step (new_empty_two_way_list, 2)
					test_indexable_with_step (new_empty_hash_table, 2)
					test_indexable_with_step (new_empty_array, 2)
					test_indexable_with_step ("", 2)

				when 11 then
					test_indexable_with_step (new_empty_linked_list, 4)
					test_indexable_with_step (new_empty_arrayed_list, 4)
					test_indexable_with_step (new_empty_two_way_list, 4)
					test_indexable_with_step (new_empty_hash_table, 4)
					test_indexable_with_step (new_empty_array, 4)
					test_indexable_with_step ("", 4)

				when 12 then
					test_indexable_reversed_with_step (new_empty_linked_list, 2)
					test_indexable_reversed_with_step (new_empty_arrayed_list, 2)
					test_indexable_reversed_with_step (new_empty_two_way_list, 2)
					test_indexable_reversed_with_step (new_empty_hash_table, 2)
					test_indexable_reversed_with_step (new_empty_array, 2)
					test_indexable_reversed_with_step ("", 2)

				when 13 then
					test_indexable_reversed_with_step (new_empty_linked_list, 4)
					test_indexable_reversed_with_step (new_empty_arrayed_list, 4)
					test_indexable_reversed_with_step (new_empty_two_way_list, 4)
					test_indexable_reversed_with_step (new_empty_hash_table, 4)
					test_indexable_reversed_with_step (new_empty_array, 4)
					test_indexable_reversed_with_step ("", 4)

				when 14 then
					test_indexable_incremented_decremented (new_empty_linked_list)
					test_indexable_incremented_decremented (new_empty_arrayed_list)
					test_indexable_incremented_decremented (new_empty_two_way_list)
					test_indexable_incremented_decremented (new_empty_hash_table)
					test_indexable_incremented_decremented (new_empty_array)
					test_indexable_incremented_decremented ("")

				end
			end
		end

	test_arguments (a: ITERABLE [STRING])
			-- Print all arguments but the first one
		local
			done: BOOLEAN
		do
			io.put_string (a.generating_type) io.put_new_line
			across a as c loop
				if done then
					io.put_string (c.item) io.put_new_line
				end
				done := True
			end
			io.put_new_line
		end

	test_iterable (a: ITERABLE [ANY])
		do
			io.put_string (a.generating_type) io.put_new_line
			across a as c loop io.put_string (c.item.out) io.put_new_line end
			io.put_new_line
		end

	test_indexable_reversed (a: READABLE_INDEXABLE [ANY])
		do
			io.put_string (a.generating_type) io.put_new_line
			across a.new_cursor.reversed as c loop
				io.put_string (c.item.out)
				io.put_new_line
			end
			io.put_new_line
		end

	test_indexable_with_step (a: READABLE_INDEXABLE [ANY]; a_step: INTEGER)
		do
			io.put_string (a.generating_type) io.put_new_line
			across a.new_cursor.with_step (a_step) as c loop
				io.put_string (c.item.out)
				io.put_new_line
			end
			io.put_new_line
		end

	test_indexable_reversed_with_step (a: READABLE_INDEXABLE [ANY]; a_step: INTEGER)
		do
			io.put_string (a.generating_type) io.put_new_line
			across a.new_cursor.with_step (a_step).reversed as c loop
				io.put_string (c.item.out)
				io.put_new_line
			end
			io.put_new_line
		end

	test_indexable_incremented_decremented (a: READABLE_INDEXABLE [ANY])
		do
			io.put_string (a.generating_type) io.put_new_line
			across a.new_cursor.incremented (2).decremented (1) as c loop
				io.put_string (c.item.out)
				io.put_new_line
			end
			io.put_new_line
		end

feature -- Containers

	new_array: ARRAY [STRING]
		once
			create Result.make (1, 0)
			Result.force ("1", 1)
			Result.force ("2", 2)
			Result.force ("3", 3)
			Result.force ("4", 4)
			Result.force ("5", 5)
			Result.force ("6", 6)
			Result.force ("7", 7)
		end

	new_linked_list: LINKED_LIST [STRING]
		once
			create Result.make
			Result.extend ("1")
			Result.extend ("2")
			Result.extend ("3")
			Result.extend ("4")
			Result.extend ("5")
			Result.extend ("6")
			Result.extend ("7")
		end

	new_two_way_list: TWO_WAY_LIST [STRING]
		once
			create Result.make
			Result.extend ("1")
			Result.extend ("2")
			Result.extend ("3")
			Result.extend ("4")
			Result.extend ("5")
			Result.extend ("6")
			Result.extend ("7")
		end

	new_arrayed_list: ARRAYED_LIST [STRING]
		once
			create Result.make (7)
			Result.extend ("1")
			Result.extend ("2")
			Result.extend ("3")
			Result.extend ("4")
			Result.extend ("5")
			Result.extend ("6")
			Result.extend ("7")
		end

	new_hash_table: HASH_TABLE [STRING, STRING]
		once
			create Result.make (7)
			Result.put ("1", "1")
			Result.put ("2", "2")
			Result.put ("3", "3")
			Result.put ("4", "4")
			Result.put ("5", "5")
			Result.put ("6", "6")
			Result.put ("7", "7")
		end
		
	new_empty_array: ARRAY [STRING]
		once
			create Result.make (1, 0)
		end

	new_empty_linked_list: LINKED_LIST [STRING]
		once
			create Result.make
		end

	new_empty_two_way_list: TWO_WAY_LIST [STRING]
		once
			create Result.make
		end

	new_empty_arrayed_list: ARRAYED_LIST [STRING]
		once
			create Result.make (7)
		end

	new_empty_hash_table: HASH_TABLE [STRING, STRING]
		once
			create Result.make (7)
		end

end
