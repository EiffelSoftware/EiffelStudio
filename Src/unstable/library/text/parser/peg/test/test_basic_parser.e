note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_BASIC_PARSER

inherit
	EQA_TEST_SET

feature -- Test routines

	test_character_parser
			-- Tests the character parser
		local
			l_char: PEG_CHARACTER
			l_res: PEG_PARSER_RESULT
		do
			create l_char.make_with_character ('a')
			l_res := l_char.parse_string ("a")
			assert ("could parse", l_res.success)
			assert ("left to parse emtpy", l_res.left_to_parse.is_empty)
			assert ("one item in result list", l_res.parse_result.count = 1)
			assert ("item is equal 'a'", l_res.parse_result.first = 'a')
		end

end


