note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_GLOBAL_VARIABLE_DESCRIPTOR

inherit
	EQA_TEST_SET

feature -- Test routines

	test_global_variable_descriptor_1
		local
			descriptor: GLOBAL_VARIABLE_DESCRIPTOR
		do
			assert ("not_implemented", False)
		end

end


