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
				create_list (i)
				test_clone (False)
				create_list (i)
				test_clone (True)
				i := i + 1
			end
		end

feature {NONE} -- Constants

	Implementations: INTEGER is 3
	
feature {NONE} -- Initialization

	l1, l2: LIST [STRING]

	create_list (i: INTEGER) is
			-- Create implementiation `i' of list.
		require
			defined_implementation: i >= 1 and i <= Implementations
		do
			inspect
				i
			when 1 then
				create {LINKED_LIST [STRING]} l1.make
			when 2 then
				create {ARRAYED_LIST [STRING]} l1.make (5)
			when 3 then
				create {FIXED_LIST [STRING]} l1.make (5)
			end
		end

	test_clone (obj_comparison: BOOLEAN) is
			-- Run clone test.
			-- Set comparison mode of `l1' to `obj_comparison'.
		do
			if obj_comparison then
				l1.compare_objects
			else
				l1.compare_references
			end
			l1.extend ("foo")
			l1.extend ("bar")
			l1.extend ("baz")
			l2 := clone (l1)
			Io.put_boolean (equal (l1, l2))
			Io.put_new_line
		end
end -- class TEST

 
