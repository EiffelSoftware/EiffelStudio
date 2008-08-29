indexing
	description: "[
		Objects that parse and evaluate comand line options for the test interpreter.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_ARGUMENT_PARSER

inherit
	ARGUMENT_MULTI_PARSER
		rename
			make as make_parser
		redefine
			switch_groups
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		do
			make_parser (False, True)
			set_is_using_separated_switch_values (True)
			set_is_showing_argument_usage_inline (True)
		end

feature -- Access

	non_switched_argument_name: !STRING = "test_id"
			-- <Precursor>

	non_switched_argument_type: !STRING = "index"
			-- <Precursor>

	non_switched_argument_description: !STRING = "Index of test to be executed"
			-- <Precursor>

	port_option: INTEGER
			-- Port number
		require
			successful: is_successful
			has_port_option
		do
			Result := option_of_name (port_switch).value.to_integer
		end

	file_option: !STRING
			-- File name of
		require
			successful: is_successful
			has_input_option: has_file_option
		do
			Result ?= option_of_name (file_switch).value
		ensure
			result_not_empty: not Result.is_empty
		end

	output_option: !STRING
			-- Location to store test reports
		require
			successful: is_successful
			has_output_option: has_output_option
		do
			Result ?= option_of_name (output_switch).value
		ensure
			result_not_empty: not Result.is_empty
		end

feature -- Status report

	has_port_option: BOOLEAN
			-- Was port switch provided?
		do
			Result := has_option (port_switch)
		end

	has_file_option: BOOLEAN
			-- Was file switch provided?
		do
			Result := has_option (file_switch)
		end

	has_output_option: BOOLEAN
			-- Was output switch provided?
		do
			Result := has_option (output_switch)
		end

feature {NONE} -- Access

	loose_argument_name: STRING = "test_name"
			-- <Precursor>

	loose_argument_description: STRING = "Name of a test procedure, i.e. MY_TESTS.test1 where MY_TESTS is the class name and test1 is the actual feature name."
			-- <Precursor>

	loose_argument_type: STRING = "Test Procedure"
			-- <Precursor>

	switches: ARRAYED_LIST [!ARGUMENT_SWITCH] is
			-- <Precursor>
		once
			create Result.make (4)
			Result.extend (create {ARGUMENT_INTEGER_SWITCH}.make (port_switch,
				"Make interpreter communicate through socket on given port", False, False, "port-number",
				"Port number", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (file_switch,
				"Make interpreter print test results to file", False, False, "file",
				"File name (WARNING: any existing file will be overwritten)", False))
			Result.extend (create {ARGUMENT_SWITCH}.make (output_switch,
				"Add test output to result", True, False))
		end

	switch_groups: ARRAYED_LIST [!ARGUMENT_GROUP]
			-- <Precursor>
		once
			create Result.make (2)
			Result.extend (create {ARGUMENT_GROUP}.make (<< switch_of_name (port_switch), switch_of_name (output_switch) >>, True))
			Result.extend (create {ARGUMENT_GROUP}.make (<< switch_of_name (file_switch), switch_of_name (output_switch) >>, False))
		end

	name: STRING = "eiffel_test_interpreter"
			-- <Precursor>

	version: STRING = "0.1"
			-- <Precursor>

feature {NONE} -- Option names

	port_switch: STRING = "p|port"
			-- Switch having interpreter communicate over socket

	file_switch: STRING = "f|file"
			-- Switch making interpreter print output to a file

	output_switch: STRING = "o|output"
			-- Switch telling interpreter to print tests output along with results

invariant
	successful_implies_port_or_file: is_successful implies (has_port_option or has_file_option)

end
