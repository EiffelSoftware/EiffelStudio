class 
	TEST

create

	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		do
			fill_arrays
			test_equality (a1, a2, "Test 1", True)
			test_equality (a3, a4, "Test 2", True)
			test_equality (a4, a5, "Test 3", False)
			test_equality (a7, a8, "Test 4", True)
		end

feature {NONE} -- Implementation

	a1, a2, a3, a4, a5, a6, a7, a8: ARRAY [STRING]

	fill_arrays is
			-- Fill the arrays.
		local
			tmp: like a1
		do
			tmp := << "foo", "bar", "baz" >>
			create a1.make_from_array (tmp)
			create a2.make_from_array (tmp)
			create a3.make_from_array (tmp)
			a3.compare_objects
			create a4.make_from_array (tmp)
			a4.compare_objects
			create a5.make_from_array (clone (tmp))
			create a6.make_from_array (clone (tmp))
			create a7.make_from_array (clone (tmp))
			a7.compare_objects
			create a8.make_from_array (clone (tmp))
			a8.compare_objects
		end

	test_equality (source, dest: like a1; label: STRING; res: BOOLEAN) is
			-- Check if `source' and `dest' are equal, name the test `label'
			-- and assume the result `res'.
		require
			source_exists: source /= Void
			destination_exists: dest /= Void
			non_empty_label: label /= Void and then not label.is_empty
		local
			r: BOOLEAN
		do
			r := equal (source, dest)
			Io.put_string (label + ": ")
			if r = res then
				Io.put_string ("OK%N")
			else
				Io.put_string ("FAILED%N")
			end
		end
		
end -- class TEST
