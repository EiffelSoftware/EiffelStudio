class 
	TEST

create
	make

feature {NONE} -- Initialization

	make is
			-- Create different descendants of LIST and execute tests.
		local
			i: INTEGER
		do
			Io.put_string ("Comparing empty lists%N")
			create {LINKED_LIST [STRING]} l1.make
			create {LINKED_LIST [STRING]} l2.make
			test_equality ("l1", "l2", l1, l2)	
			Io.put_new_line
			from i := 1 until i > 4 loop
				inspect
					i
				when 1 then
					create {LINKED_LIST [STRING]} l1.make
					create {LINKED_LIST [STRING]} l4.make
					create {LINKED_LIST [STRING]} l5.make
					Io.put_string ("LINKED_LIST%N")
				when 2 then
					create {TWO_WAY_LIST [STRING]} l1.make
					create {TWO_WAY_LIST [STRING]} l4.make
					create {TWO_WAY_LIST [STRING]} l5.make
					Io.put_string ("TWO_WAY_LIST%N")
				when 3 then
					create {ARRAYED_LIST [STRING]} l1.make (5)
					create {ARRAYED_LIST [STRING]} l4.make (5)
					create {ARRAYED_LIST [STRING]} l5.make (5)
					Io.put_string ("ARRAYED_LIST%N")
				when 4 then
					create {SORTED_TWO_WAY_LIST [STRING]} l1.make
					create {SORTED_TWO_WAY_LIST [STRING]} l4.make
					create {SORTED_TWO_WAY_LIST [STRING]} l5.make
					Io.put_string ("SORTED_TWO_WAY_LIST%N")
				end

				fill_up
				comparisons
				i := i + 1
			end
		end

feature {NONE} -- Implementation

	l1, l2, l3, l4, l5: LIST [STRING]

	test_equality (sname, dname: STRING; src, dest: LIST [STRING]) is
			-- Compare list `src' and `dest', named `sname' and `dname'.
		do
			Io.put_string (sname)
			Io.put_string (" = ")
			Io.put_string (dname)
			Io.put_string (" (comparing ")
			if src.object_comparison then
				Io.put_string ("objects): ")
			else
				Io.put_string ("references): ")
			end
			Io.put_boolean (src.is_equal (dest))
			Io.put_new_line
		end

	fill_up is
			-- Fill the containers up.
		local
			s1: STRING
			s2: STRING
		do
			s1 := "a"
			l1.extend (s1)
			s1 := "b"
			l1.extend (s1)
			l3 := deep_clone (l1)
			s1 := "c"
			l1.extend (s1)
			l2 := clone (l1)
			s2 := clone (s1)
			l3.extend (s2)
		end

	comparisons is
			-- Do the comparisons.
		do
			l1.compare_references
			test_equality ("l1", "l1", l1, l1)
			test_equality ("l1", "l2", l1, l2)
			test_equality ("l1", "l3", l1, l3)
			test_equality ("l1", "l4", l1, l4)
			test_equality ("l4", "l1", l4, l1)
			test_equality ("l4", "l5", l4, l5)
			Io.put_new_line
			l1.compare_objects
			test_equality ("l1", "l2", l1, l2)
			test_equality ("l1", "l3", l1, l3)
			test_equality ("l1", "l4", l1, l4)
			test_equality ("l4", "l1", l4, l1)
			test_equality ("l4", "l5", l4, l5)
			l4.compare_objects
			test_equality ("l4", "l5", l4, l5)
			Io.put_new_line
			l2.compare_objects
			l3.compare_objects
			l5.compare_objects
			test_equality ("l1", "l2", l1, l2)
			test_equality ("l1", "l3", l1, l3)
			test_equality ("l1", "l4", l1, l4)
			test_equality ("l4", "l1", l4, l1)
			test_equality ("l4", "l5", l4, l5)
			Io.put_new_line
		end

end -- class TEST
