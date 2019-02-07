note

	description:

		"Test for validity rule VEVI"

	copyright: "Copyright (c) 2011-2017, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class TEST_VEVI_TEST4

inherit

	EIFFEL_TEST_CASE

create

	make_default

feature -- Test

	test_validity
			-- Test for validity rule VEVI.
		do
			compile_and_test ("test4")
		end

feature {NONE} -- Implementation

	rule_dirname: STRING
			-- Name of the directory containing the tests of the rule being tested
		do
			Result := file_system.nested_pathname ("${GOBO}", <<"library", "tools", "test", "eiffel", "validity", "vevi">>)
			Result := Execution_environment.interpreted_string (Result)
		end

	testdir: STRING
			-- Name of temporary directory where to run the test
		do
			Result := "Ttest4"
		end

end
