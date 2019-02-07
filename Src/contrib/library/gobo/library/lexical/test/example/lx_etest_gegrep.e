note

	description:

		"Test 'gegrep' example"

	library: "Gobo Eiffel Lexical Library"
	copyright: "Copyright (c) 2001, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class LX_ETEST_GEGREP

inherit

	EXAMPLE_TEST_CASE

create

	make_default

feature -- Access

	program_name: STRING = "gegrep"
			-- Program name

	library_name: STRING = "lexical"
			-- Library name of example

feature -- Test

	test_gegrep
			-- Test 'gegrep' example.
		do
			compile_program
		end

end
