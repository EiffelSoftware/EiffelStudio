class 
	TEST

create

	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		do
			create_sets
			fill_sets (False, False)
			check_sets
			create_sets
			fill_sets (True, False)
			check_sets
			create_sets
			fill_sets (False, True)
			check_sets
			create_sets
			fill_sets (True, True)
			check_sets
		end

feature {NONE} -- Implementation

	set1, set2: TWO_WAY_SORTED_SET [INTEGER]

	create_sets is
			-- Create sets.
		do
			Io.put_string ("Create set%N")
			create set1.make
			create set2.make
		end

	fill_sets (disjoint, obj_comparison: BOOLEAN) is
			-- Fill sets with (non-)disjoint data and set 
			-- `object_comparison' of the sets to `comparison'.
		require
			sets_exist: set1 /= Void and set2 /= Void
		do
			if obj_comparison then
				Io.put_string ("object comparison set%N")
				set1.compare_objects
				set2.compare_objects
			else
				Io.put_string ("reference comparison set%N")
				set1.compare_references
				set2.compare_references
			end
			if disjoint then
				Io.put_string ("Filling set with disjoint data%N")
				set1.put (1)
				set1.put (3)
				set1.put (6)
				set2.put (2)
				set2.put (4)
				set2.put (7)
			else
				Io.put_string ("Filling set with non-disjoint data%N")
				set1.put (1)
				set1.put (3)
				set1.put (5)
				set2.put (2)
				set2.put (4)
				set2.put (5)
			end
		ensure
			sets_filled: not set1.is_empty and not set2.is_empty
		end
		
	check_sets is
			-- Process sets.
		require
			sets_exist: set1 /= Void and set2 /= Void
			sets_filled: not set1.is_empty and not set2.is_empty
		do
			Io.put_string ("set disjoint: ")
			Io.put_boolean (set1.disjoint (set2))
			Io.put_new_line
		end
		
end -- class TEST

 
