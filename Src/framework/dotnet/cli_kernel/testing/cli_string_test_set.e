note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	CLI_STRING_TEST_SET

inherit
	EQA_TEST_SET

feature -- Test routines

	test_cli_string
			-- New test routine
		note
			testing:  "covers/{CLI_STRING}"
		local
			str: STRING_32
			cstr: CLI_STRING
		do
			str := {STRING_32} "abc"
			create cstr.make (str)

			assert ("same plain text string", cstr.string_32.same_string (str))

			str := {STRING_32} "binary[%/0c000/%/0c001/%/0c002/%/0c003/%/0c004/%/0c005/]"
			create cstr.make (str)

			assert ("same binary string", cstr.string_32.same_string (str))

		end

end


