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

			create l_string.make (1)
			l_string.append_character (utilities.split_char)
			asserter.disassert ("split_char_not_valid",
			                    utilities.is_valid_token (l_string))

			assert ("alpha_token_valid",
			        utilities.is_valid_token ("abcdefghijklmnopqrstwuvxyz"))
		end

	test_join_tags
			-- Test routines for `join_tags'
		indexing
			testing: "covers/{TAG_UTILITIES}.is_valid_token",
			         "tests/eiffel/statics/tagable"
		local
			l_tag1, l_tag2, l_result: !STRING
		do
			l_tag1 := ""
			l_tag2 := ""
			l_result := l_tag1
			assert ("both_empty", l_result.is_equal (utilities.join_tags (l_tag1, l_tag2)))

			l_tag1.append ("token1/token2")
			l_result := l_tag1
			assert ("first_empty", l_result.is_equal (utilities.join_tags (l_tag1, l_tag2)))
			assert ("second_empty", l_result.is_equal (utilities.join_tags (l_tag2, l_tag1)))

			l_tag2 := "token3"
			l_result := "token1/token2/token3"
			assert ("none_empty", l_result.is_equal (utilities.join_tags (l_tag1, l_tag2)))
		end
end
