class 
	TEST

create

	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > 2
			loop
				create_int_sets (i)
				fill_int_sets (True)
				check_int_sets
				create_int_sets (i)
				fill_int_sets (False)
				check_int_sets
				create_string_sets (i)
				fill_string_sets (True, False)
				check_string_sets
				create_string_sets (i)
				fill_string_sets (False, False)
				check_string_sets
				create_string_sets (i)
				fill_string_sets (True, True)
				check_string_sets
				create_string_sets (i)
				fill_string_sets (False, True)
				check_string_sets
				i := i + 1
			end
		end

feature {NONE} -- Implementation

	int_set1, int_set2: SUBSET [INTEGER]

	string_set1, string_set2: SUBSET [STRING]

	list_set1, list_set2: SUBSET [LINKED_LIST [INTEGER]]

	create_int_sets (impl: INTEGER) is
			-- Create integer sets using the implementation determined by
			-- `impl'.
		require
			defined_implementation: 1 <= impl and impl <= 2
		do
			inspect
				impl
			when 1 then
				Io.put_string ("Create integer set as type LINKED_SET%N")
				create {LINKED_SET [INTEGER]} int_set1.make
				create {LINKED_SET [INTEGER]} int_set2.make
			when 2 then
				Io.put_string ("Create integer set as type BINARY_SEARCH_TREE_SET%N")
				create {BINARY_SEARCH_TREE_SET [INTEGER]} int_set1.make
				create {BINARY_SEARCH_TREE_SET [INTEGER]} int_set2.make
			end
		end

	create_string_sets (impl: INTEGER) is
			-- Create string sets using the implementation determined by
			-- `impl'.
		require
			defined_implementation: 1 <= impl and impl <= 2
		do
			inspect
				impl
			when 1 then
				Io.put_string ("Create string set as type LINKED_SET%N")
				create {LINKED_SET [STRING]} string_set1.make
				create {LINKED_SET [STRING]} string_set2.make
			when 2 then
				Io.put_string ("Create string set as type BINARY_SEARCH_TREE_SET%N")
				create {BINARY_SEARCH_TREE_SET [STRING]} string_set1.make
				create {BINARY_SEARCH_TREE_SET [STRING]} string_set2.make
			end
		end

	fill_int_sets (disjoint: BOOLEAN) is
			-- Fill integer sets with disjoint/non-disjoint data.
		require
			sets_exist: int_set1 /= Void and int_set2 /= Void
		do
			if disjoint then
				Io.put_string ("Filling integer set with disjoint data%N")
				int_set1.put (1)
				int_set1.put (3)
				int_set2.put (2)
				int_set2.put (4)
			else
				Io.put_string ("Filling integer set with non-disjoint data%N")
				int_set1.put (1)
				int_set1.put (3)
				int_set2.put (1)
				int_set2.put (4)
			end
		ensure
			sets_filled: not int_set1.is_empty and not int_set2.is_empty
		end
		
	fill_string_sets (disjoint, obj_comparison: BOOLEAN) is
			-- Fill string sets with disjoint/non-disjoint data and set
			-- `object_comparison' of the sets to `obj_comparison'.
		require
			sets_exist: string_set1 /= Void and string_set2 /= Void
		local
			s1, s2: STRING
		do
			if obj_comparison then
				Io.put_string ("object comparison set%N")
				string_set1.compare_objects
				string_set2.compare_objects
			else
				Io.put_string ("reference comparison set%N")
				string_set1.compare_references
				string_set2.compare_references
			end
			if disjoint then
				Io.put_string ("Filling string set with disjoint data%N")
				string_set1.put ("foo")
				string_set1.put ("bar")
				string_set2.put ("bla")
				string_set2.put ("baz")
			else
				Io.put_string ("Filling string set with non-disjoint data%N")
				s1 := "foo"
				s2 := clone (s1)
				string_set1.put (s1)
				string_set1.put ("bar")
				string_set2.put (s2)
				string_set2.put ("baz")
			end
		ensure
			sets_filled: not string_set1.is_empty and not string_set2.is_empty
			same_comparison: string_set1.object_comparison =
						string_set2.object_comparison
		end
		
	check_int_sets is
			-- Check integer sets.
		require
			sets_exist: int_set1 /= Void and int_set2 /= Void
			sets_filled: not int_set1.is_empty and not int_set2.is_empty
		do
			Io.put_string ("integer sets disjoint: ")
			Io.put_boolean (int_set1.disjoint (int_set2))
			Io.put_new_line
		end
		
	check_string_sets is
			-- Check string sets.
		require
			sets_exist: string_set1 /= Void and string_set2 /= Void
			sets_filled: not string_set1.is_empty and not string_set2.is_empty
		do
			Io.put_string ("string sets disjoint: ")
			Io.put_boolean (string_set1.disjoint (string_set2))
			Io.put_new_line
		end
		
end -- class TEST

 
