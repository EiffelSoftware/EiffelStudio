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
			l_exp: EXPANDED_CLASS
			l_m: MULTI [EXPANDED_CLASS]
		do
			create l_m
			l_m.p (l_exp)
		end

end 
