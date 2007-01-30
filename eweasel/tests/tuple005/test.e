class TEST

create
    make

feature

	make is
		local
			t1, t2: TUPLE [INTEGER, CHARACTER, STRING]
			l_mem: MEMORY
		do
			t1 := [1, 'c', "My TEST"]
			t2 := [1, 'c', "My TEST"]

			io.put_string ("Comparison status: ")
			io.put_boolean (t1.object_comparison)
			io.put_character (' ')
			io.put_boolean (t2.object_comparison)
			io.new_line
			io.put_string ("is_equal? ")
			io.put_boolean (t1.is_equal (t2))
			io.new_line

			t1.compare_objects
			t2.compare_objects
			io.put_string ("Comparison status: ")
			io.put_boolean (t1.object_comparison)
			io.put_character (' ')
			io.put_boolean (t2.object_comparison)
			io.new_line
			io.put_string ("is_equal? ")
			io.put_boolean (t1.is_equal (t2))
			io.new_line

			t1.compare_objects
			t2.compare_references
			io.put_string ("Comparison status: ")
			io.put_boolean (t1.object_comparison)
			io.put_character (' ')
			io.put_boolean (t2.object_comparison)
			io.new_line
			io.put_string ("is_equal? ")
			io.put_boolean (t1.is_equal (t2))
			io.new_line

			t1.compare_references
			t2.compare_objects
			io.put_string ("Comparison status: ")
			io.put_boolean (t1.object_comparison)
			io.put_character (' ')
			io.put_boolean (t2.object_comparison)
			io.new_line
			io.put_string ("is_equal? ")
			io.put_boolean (t1.is_equal (t2))
			io.new_line

				-- Check that setting the `object_comparison' boolean does not mess up the GC.
			t1.compare_references
			t2.compare_references
			create l_mem
			l_mem.collect
			l_mem.full_collect
		end

end -- class TEST
