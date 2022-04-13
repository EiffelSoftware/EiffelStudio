note
	description: "Summary description for {TEST_JSON_EVENT_PARSER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_JSON_EVENT_PARSER

inherit
	EQA_TEST_SET

	TEST_JSON_I
		redefine
			new_empty_parser
		end

feature -- Factory

	new_empty_parser: JSON_PARSER-- JSON_EVENT_STANDARD_PARSER
		do
			create Result.make
		end

feature -- Test

	test_parser
		local
			parser: like new_empty_parser
		do
			parser := new_empty_parser
			parser.parse_string ("{%"name%": %"value%"}")

		end

end
