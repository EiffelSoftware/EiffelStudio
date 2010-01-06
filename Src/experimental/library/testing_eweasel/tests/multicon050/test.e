indexing
	description	: "This test mainly tests infix features together with multi constraints including renaming."
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

create
	make

feature -- Initialization
	a: DOUBLE

	make is
			-- Creation procedure.
		local
			l: MULTI [ARRAY[like a], like a]
			array: ARRAY [like a]

			i: INTEGER
		do
			create array.make (1, 4);
			from i := 1 until i > 4
			loop
				array.put(42+i, i)
				i := i + 1
			end

			create l.make (array)

			a := array @ 1
			a := l.g @ 3
		end

end
