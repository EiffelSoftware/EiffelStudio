note

	description:

		"Test 'event/tagcount' example"

	library: "Gobo Eiffel XML Library"
	copyright: "Copyright (c) 2003-2016, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class XM_ETEST_TAGCOUNT

inherit

	EXAMPLE_TEST_CASE
		redefine
			program_dirname
		end

create

	make_default

feature -- Access

	program_name: STRING = "tagcount"
			-- Program name

	library_name: STRING = "xml"
			-- Library name of example

feature -- Test

	test_print
			-- Test 'event/tagcount' example.
		do
			compile_program
		end

feature {NONE} -- Implementation

	program_dirname: STRING
			-- Name of program source directory
		do
			Result := file_system.nested_pathname ("${GOBO}", <<"library", library_name, "example", "event", program_name>>)
			Result := Execution_environment.interpreted_string (Result)
		end

end
