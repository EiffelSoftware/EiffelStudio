note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_DERIVED_TYPE_DESCRIPTOR

inherit
	EQA_TEST_SET

feature -- Test routines

	test_derived_type_descriptor_1
		local
			descriptor: DERIVED_TYPE_DESCRIPTOR
		do
			assert ("not_implemented", False)
		end

end


