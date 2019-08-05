note
	description : "Objects that ..."
	author: "$Author: manus $"
	date: "$Date: 2014-03-21 01:22:49 +0100 (Fri, 21 Mar 2014) $"
	revision: "$Revision: 94660 $"

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
