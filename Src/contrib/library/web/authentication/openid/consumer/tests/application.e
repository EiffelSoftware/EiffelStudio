note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			test_openid
		end

	test_openid
		local
			t: TEST_OPENID
		do
			create t.make
		end

end
