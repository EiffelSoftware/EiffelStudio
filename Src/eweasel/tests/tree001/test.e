class 
	TEST

create

	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		do
			run_test (False, False, 100, 100)
			run_test (False, True, 100, 100)
			run_test (True, False, 100, 100)
			run_test (True, True, 100, 100)
			run_test (False, False, 100, 10)
			run_test (False, True, 100, 10)
			run_test (True, False, 100, 10)
			run_test (True, True, 100, 10)
			run_test (False, False, 10, 100)
			run_test (False, True, 10, 100)
			run_test (True, False, 10, 100)
			run_test (True, True, 10, 100)
		end

feature {NONE} -- Implementation

	tree1, tree2: BINARY_SEARCH_TREE [STRING]

	run_test (obj1, obj2: BOOLEAN; size1, size2: INTEGER) is
			-- Run test with the following parameters:
			-- `obj1' sets comparison mode of `tree1'.
			-- `obj2' sets comparison mode of `tree2'.
			-- `size1' sets size of `tree1'.
			-- `size2' sets size of `tree2'.
		require
			non_negative_sizes: size1 >= 0 and size2 >= 0
		do
			create tree1.make ("1")
			create tree2.make ("1")
			if obj1 then
				tree1.compare_objects
			else
				tree1.compare_references
			end
			if obj2 then
				tree2.compare_objects
			else
				tree2.compare_references
			end
			fill_tree (tree1, size1)
			fill_tree (tree2, size2)
			Io.put_string ("Tree 1: object comparison: " + obj1.out +
					", size: " + size1.out + "%N")
			Io.put_string ("Tree 2: object comparison: " + obj2.out +
					", size: " + size2.out + "%N")
			Io.put_string ("Result: " + equal (tree1, tree2).out + "%N%N")
		end

		fill_tree (t: like tree1; size: INTEGER) is
				-- Fill `t' with `size' items.
			require
				tree_exists: t /= Void
				positive_size: size > 0
			local
				i: INTEGER
				item: INTEGER
				old_count: INTEGER
			do
				from
					i := 2
				until
					i > size
				loop
					if i \\ 2 = 0 then
						item := size + 1 - (i // 2)
					else
						item := 1 + (i // 2)
					end
					old_count := t.count
					t.extend (item.out)
					check
						inserted: t.count = old_count + 1
							-- Because we inserted an item
					end
					i := i + 1
				end
			ensure
				filled: t.count = size
			end

end -- class TEST
