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
			create_obj_sets
			fill_obj_sets (False)
			process_obj_sets
			create_obj_sets
			fill_obj_sets (True)
			process_obj_sets
			create_obj_cmp_sets
			fill_obj_cmp_sets (False)
			process_obj_cmp_sets
			create_obj_cmp_sets
			fill_obj_cmp_sets (True)
			process_obj_cmp_sets
			from
				i := 1
			until
				i > Implementations
			loop
				create_string_sets (i)
				fill_string_sets (False)
				process_string_sets
				create_string_sets (i)
				fill_string_sets (True)
				process_string_sets
				i := i + 1
			end
		end

feature {NONE} -- Constants

	Implementations: INTEGER is 2
	
feature {NONE} -- Implementation

	obj_set1, obj_set2: TRAVERSABLE_SUBSET [SAMPLE_OBJECT]

	string_set1, string_set2: TRAVERSABLE_SUBSET [STRING]

	create_obj_sets is
			-- Create object sets.
		do
			Io.put_string ("Create object set as type LINKED_SET%N")
			create {LINKED_SET [SAMPLE_OBJECT]} obj_set1.make
			create {LINKED_SET [SAMPLE_OBJECT]} obj_set2.make
		end

	create_obj_cmp_sets is
			-- Create comparable object sets.
		do
			Io.put_string ("Create comparable object set as type BINARY_SEARCH_TREE_SET%N")
			create {BINARY_SEARCH_TREE_SET [SAMPLE_OBJECT_COMPARABLE]} obj_set1.make
			create {BINARY_SEARCH_TREE_SET [SAMPLE_OBJECT_COMPARABLE]} obj_set2.make
		end

	create_string_sets (impl: INTEGER) is
			-- Create string sets using the implementation determined by
			-- `impl'.
		require
			defined_implementation: 1 <= impl and impl <= Implementations
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

	fill_obj_sets (obj_comparison: BOOLEAN) is
			-- Fill object sets and set `object_comparison' of the sets to
			-- `obj_comparison'.
		require
			sets_exist: obj_set1 /= Void and obj_set2 /= Void
		local 
			o: SAMPLE_OBJECT
		do
			if obj_comparison then
				Io.put_string ("object comparison set%N")
				obj_set1.compare_objects
				obj_set2.compare_objects
			else
				Io.put_string ("reference comparison set%N")
				obj_set1.compare_references
				obj_set2.compare_references
			end
			Io.put_string ("Filling object set%N")
			create o.make (1)
			obj_set1.put (o)
			create o.make (3)
			obj_set1.put (o)
			create o.make (5)
			obj_set1.put (o)
			if obj_comparison then create o.make (5) end
			obj_set2.put (o)
			create o.make (2)
			obj_set2.put (o)
			create o.make (4)
			obj_set2.put (o)
		ensure
			sets_filled: not obj_set1.is_empty and not obj_set2.is_empty
		end
		
	fill_obj_cmp_sets (obj_comparison: BOOLEAN) is
			-- Fill object sets and set `object_comparison' of the sets to
			-- `obj_comparison'.
		require
			sets_exist: obj_set1 /= Void and obj_set2 /= Void
		local 
			o: SAMPLE_OBJECT_COMPARABLE
		do
			if obj_comparison then
				Io.put_string ("object comparison set%N")
				obj_set1.compare_objects
				obj_set2.compare_objects
			else
				Io.put_string ("reference comparison set%N")
				obj_set1.compare_references
				obj_set2.compare_references
			end
			Io.put_string ("Filling comparable object set%N")
			create o.make (1)
			obj_set1.put (o)
			create o.make (3)
			obj_set1.put (o)
			create o.make (5)
			obj_set1.put (o)
			if obj_comparison then create o.make (5) end
			obj_set2.put (o)
			create o.make (2)
			obj_set2.put (o)
			create o.make (4)
			obj_set2.put (o)
		ensure
			sets_filled: not obj_set1.is_empty and not obj_set2.is_empty
		end
		
	fill_string_sets (obj_comparison: BOOLEAN) is
			-- Fill string sets and set `object_comparison' of the sets to
			-- `obj_comparison'.
		require
			sets_exist: string_set1 /= Void and string_set2 /= Void
		local
			s: STRING
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
			Io.put_string ("Filling string set%N")
			string_set1.put ("foo")
			string_set1.put ("bar")
			if obj_comparison then
				string_set1.put ("boo")
				string_set2.put ("boo")
			else
				s := "boo"
				string_set1.put (s)
				string_set2.put (s)
			end
			string_set2.put ("bla")
			string_set2.put ("baz")
		ensure
			sets_filled: not string_set1.is_empty and not string_set2.is_empty
			same_comparison: string_set1.object_comparison =
						string_set2.object_comparison
		end
		
	process_obj_sets is
			-- Process object sets.
		require
			sets_exist: obj_set1 /= Void and obj_set2 /= Void
			sets_filled: not obj_set1.is_empty and not obj_set2.is_empty
		do
			obj_set1.symdif (obj_set2)
			Io.put_string ("Set 1: ")
			from obj_set1.start until obj_set1.after loop
				Io.put_integer (obj_set1.item.item)
				Io.put_string (", ")
				obj_set1.forth
			end
			Io.put_new_line
			Io.put_string ("Set 2: ")
			from obj_set2.start until obj_set2.after loop
				Io.put_integer (obj_set2.item.item)
				Io.put_string (", ")
				obj_set2.forth
			end
			Io.put_new_line
		end
		
	process_obj_cmp_sets is
			-- Process comparable object sets.
		require
			sets_exist: obj_set1 /= Void and obj_set2 /= Void
			sets_filled: not obj_set1.is_empty and not obj_set2.is_empty
		do
			obj_set1.symdif (obj_set2)
			Io.put_string ("Set 1: ")
			from obj_set1.start until obj_set1.after loop
				Io.put_integer (obj_set1.item.item)
				Io.put_string (", ")
				obj_set1.forth
			end
			Io.put_new_line
			Io.put_string ("Set 2: ")
			from obj_set2.start until obj_set2.after loop
				Io.put_integer (obj_set2.item.item)
				Io.put_string (", ")
				obj_set2.forth
			end
			Io.put_new_line
		end
		
	process_string_sets is
			-- Process string sets.
		require
			sets_exist: string_set1 /= Void and string_set2 /= Void
			sets_filled: not string_set1.is_empty and not string_set2.is_empty
		do
			string_set1.symdif (string_set2)
			Io.put_string ("Set 1: ")
			from string_set1.start until string_set1.after loop
				Io.put_string (string_set1.item)
				Io.put_string (", ")
				string_set1.forth
			end
			Io.put_new_line
			Io.put_string ("Set 2: ")
			from string_set2.start until string_set2.after loop
				Io.put_string (string_set2.item)
				Io.put_string (", ")
				string_set2.forth
			end
			Io.put_new_line
		end
		
end -- class TEST

 
