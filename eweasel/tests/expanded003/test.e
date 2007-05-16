indexing
	description	: "System's root class"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

create
	make

feature -- Initialization

	make is
			-- Creation procedure.
		do
			create test_array.make( 0, 1000 )
			from until false loop
				play
			end
		end

	test_array: ARRAY[ B ]

feature
	f: A
	play is
			-- 
		local
			f1,f2: A
		do
			f := f1
			f := f2
		end

end -- class ROOT_CLASS
