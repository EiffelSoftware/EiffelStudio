indexing

	description:

		"Test 'getest'"

	copyright: "Copyright (c) 2001-2002, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class TEST_GETEST

inherit

	TOOL_TEST_CASE

create

	make_default

feature -- Access

	program_name: STRING is "getest"
			-- Program name

feature -- Test

	test_getest is
			-- Test 'getest'.
		do
			compile_program
		end

end
