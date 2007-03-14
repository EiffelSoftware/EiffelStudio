indexing
description	: "This test checks that we get an error if someone renames a feature which does not exist in the base class."
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
			l: MULTI [ARRAYED_LIST[like a], like a]
			arrayed_list: ARRAYED_LIST[like a]
		do
		end

end
