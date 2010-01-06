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
		local
			l_m: MULTI [INTEGER]
			l_integer: INTEGER
		do
			l_integer := 7
			l_integer.set_item (42)
			print (l_integer); io.put_new_line
			create l_m
			l_m.p (42)

		end

end 
