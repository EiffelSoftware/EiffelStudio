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
				i > Implementations
			loop
				test_twin (new_list (i), False)
				test_twin (new_list (i), True)
				test_copy (new_list (i), new_list (i), new_list (i), False)
				test_copy (new_list (i), new_list (i), new_list (i), True)
				i := i + 1
			end
		end

feature {NONE} -- Constants

	Implementations: INTEGER is 3
	
feature {NONE} -- Initialization


	new_list (i: INTEGER): LIST [STRING] is
			-- Create implementiation `i' of list.
		require
			defined_implementation: i >= 1 and i <= Implementations
		do
			inspect
				i
			when 1 then
				create {LINKED_LIST [STRING]} Result.make
			when 2 then
				create {ARRAYED_LIST [STRING]} Result.make (5)
			when 3 then
				create {FIXED_LIST [STRING]} Result.make (5)
			end
		end

	test_twin (a_list: LIST [STRING]; obj_comparison: BOOLEAN) is
			-- Run twin test.
			-- Set comparison mode of `a_list' to `obj_comparison'.
		local
			l2: LIST [STRING]
		do
			if obj_comparison then
				a_list.compare_objects
			else
				a_list.compare_references
			end
			a_list.extend ("foo")
			a_list.extend ("bar")
			a_list.extend ("baz")
			
			l2 := a_list.twin
			if a_list /~ l2 then
				io.put_string ("Failure%N")
			end
		end

	test_copy (a_list1, a_list2, a_list3: LIST [STRING]; obj_comparison: BOOLEAN) is
			-- Run copy test.
			-- Set comparison mode of `a_list1' and `a_list2' to `obj_comparison'.
		do
			if obj_comparison then
				a_list1.compare_objects
				a_list2.compare_objects
			else
				a_list1.compare_references
				a_list2.compare_references
			end
			a_list1.extend ("foo")
			a_list1.extend ("bar")
			a_list1.extend ("baz")
			
			a_list2.copy (a_list1)
			if a_list1 /~ a_list2 then
				io.put_string ("Failure%N")
			end

			a_list3.extend ("bar")
			a_list3.copy (a_list1)
			if a_list1 /~ a_list3 then
				io.put_string ("Failure%N")
			end

			if a_list1.is_empty then
				io.put_string ("Failure%N")
			end
			a_list1.copy (a_list1)
			if a_list1.is_empty then
				io.put_string ("Failure%N")
			end
		end

end -- class TEST

 
