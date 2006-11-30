class TEST

create
	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		local
			a: ARRAY [ANY]
		do
			create a.make (1, 3)
			a.compare_objects; test (a)
			a.put (a, 1);      test (a)
			a.put (a, 2);      test (a)
			a.put (a, 3);      test (a)
			a.put (Void, 1);   test (a)
			a.put (Void, 2);   test (a)
			a.put (Void, 3);   test (a)
			a.put (a, 2);      test (a)
		end

feature {NONE} -- Implementation

	test (a: ARRAY [ANY]) is
			-- Print results of the following calls:
			-- a.occurrences (Void)
			-- a.occurrences (a)
			-- a.occurrences (create {ANY})
		require
			a_not_void: a /= Void
		do
			io.put_integer (a.occurrences (Void))
			io.put_integer (a.occurrences (a))
			io.put_integer (a.occurrences (create {ANY}))
			io.put_new_line
		end

end
