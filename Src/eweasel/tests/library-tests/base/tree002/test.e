class 
	TEST

create

	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		do
			run_test (False)
			run_test (True)
		end

feature {NONE} -- Constants

	Items: INTEGER is 4

feature {NONE} -- Initialization

	t1, t2: BINARY_SEARCH_TREE [STRING]

	run_test (object_comparison: BOOLEAN) is
			-- Set `object_comparison' and run test.
		do
			create t1.make ("1")
			if object_comparison then
				t1.compare_objects
			else
				t1.compare_references
			end
			fill_tree (t1, Items)
			t2 := clone (t1)
			Io.put_boolean (equal (t1, t2))
			Io.put_new_line
		end

		fill_tree (t: like t1; size: INTEGER) is
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
