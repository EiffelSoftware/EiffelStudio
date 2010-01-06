indexing
description	: "This test creates objects by a creation feature which is provided through a constraint which is of formal type:"
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
			l: MULTI [like a, DOUBLE_REF]
			l2: MULTI2 [like a, DOUBLE_REF, COMPARABLE]
		do
			create l.make
			create l2.make
		end

end
