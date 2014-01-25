note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_DEBUG_LOC

inherit
	EQA_TEST_SET

feature -- Test routines

	test_debug_loc_1
		local
			loc: DEBUG_LOC
		do
			assert ("not_implemented", False)
		end

end


