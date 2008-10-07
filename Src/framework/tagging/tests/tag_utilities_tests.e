indexing
	description: "[
		Regression tests for {TAG_UTILITIES_TESTS}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TAG_UTILITIES_TESTS

inherit
	TEST_SET
		redefine
			setup
		end

feature -- Initialization

	setup
			-- <Precursor>
		do
			create utilities
		end

feature {NONE} -- Access

	utilities: !TAG_UTILITIES

feature -- Tests

	test_is_valid_token
			-- Test routines for `is_valid_token'
		indexing
			testing: "covers/{TAG_UTILITIES}.is_valid_token",
			         "tests/eiffel/statics/tagable"
		local
			l_string: !STRING
		do
			asserter.disassert ("empty_token_invalid",
			                    utilities.is_valid_token (""))

			l_string ?= utilities.split_char.out
			asserter.disassert ("split_char_not_valid",
			                    utilities.is_valid_token (l_string))

			assert ("alpha_token_valid",
			        utilities.is_valid_token ("abcdefghijklmnopqrstwuvxyz"))
		end

end
