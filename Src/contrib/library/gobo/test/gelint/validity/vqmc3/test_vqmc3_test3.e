indexing

	description:

		"Test for validity rule VQMC-3"

	remark: "[
		In this test the octal integer constant '0c200' (i.e. 128) in
		'cc: INTEGER_8 = 0c200' is too big to be representable as an INTEGER_8.

		This rule is in ECMA 367-2, section 8.18.2, p.100.
		ISE reports that the type of 128 is INTEGER_32 and hence does not match
		the declared type INTEGER_8. This is not quite what ECMA 367-2 expects.
	]"

	copyright: "Copyright (c) 2009, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class TEST_VQMC3_TEST3

inherit

	GELINT_TEST_CASE

create

	make_default

feature -- Test

	test_validity is
			-- Test for validity rule VQMC-3.
		do
			compile_and_test ("test3")
		end

feature {NONE} -- Implementation

	rule_dirname: STRING is
			-- Name of the directory containing the tests of the rule being tested
		do
			Result := file_system.nested_pathname ("${GOBO}", <<"test", "gelint", "validity", "vqmc3">>)
			Result := Execution_environment.interpreted_string (Result)
		end

	testdir: STRING is
			-- Name of temporary directory where to run the test
		do
			Result := "Ttest3"
		end

end
