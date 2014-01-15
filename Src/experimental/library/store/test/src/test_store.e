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
			t: TEST_NUMERIC_TYPES
		do
			create t
			t.test_numeric_types
		end

end
