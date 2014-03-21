note
	description : "Objects that ..."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_STORE

inherit
	ANY

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		local
			t: TEST_LARGE_DATA
		do
			create t
			t.test_large_string
		end

end
