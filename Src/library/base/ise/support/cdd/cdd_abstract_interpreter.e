indexing
	description: "[
			Objects that run test cases and print testing result
			to console. Descendants of this class should be used
			as the root class of some target.
		]"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CDD_ABSTRACT_INTERPRETER

inherit

	CDD_REQUEST_PARSER

	EXCEPTIONS
		export {NONE} all	end

	EXECUTION_ENVIRONMENT
		export {NONE} all	end

feature {NONE} -- Execution

	execute is
			-- If command line arguments are provided, only execute
			-- test cases matching these arguments. Otherwise
			-- execute all test cases in `test_cases'.
		do
			make
			main_loop
		end

	main_loop is
			-- Wait for requests on standard input. If request
			-- is received, parse it.
		local
			l_input: STRING
		do
			from
			until
				should_quit or io.input.end_of_file
			loop
				io.input.read_line
				l_input := io.input.last_string
				if l_input = Void then
					print_and_flush ("error: empty input%N")
				else
					set_input (l_input)
					parse
				end
			end
		end

feature -- Access

	test_class_instance (a_name: STRING): CDD_TEST_CASE is
			-- Instance of test class with name `a_name'. Void if no such
			-- test class.
		require
			a_name_not_void: a_name /= Void
		deferred
		end

	test_procedure (a_name: STRING): PROCEDURE [ANY, TUPLE [CDD_TEST_CASE]] is
			-- Agent of test procedure named `a_name'. Note that `a_name'
			-- has to contain the class name a dot followed by the
			-- procedure name. E.g. "MY_TEST_CASE.test_001". Void if no
			-- such procedure.
		require
			a_name_not_void: a_name /= Void
		deferred
		end

feature {NONE} -- Request handling

	report_quit_request is
			-- Set `should_quit' to True.
		do
			should_quit := True
		end

	report_list_test_classes_request is
			-- Print a list of all test cases and their test features.
		do
			-- TODO: implement
				check
					TODO: False
				end
		end

	report_list_of_class_request (a_class_name: STRING) is
			-- Print a list of all test features in class `a_class_name'.
		do
			-- TODO: implement
				check
					TODO: False
				end
		end

	report_execute_all_test_routines_request is
			-- Execute all tests in all test cases.
		do
			-- TODO: implement
			check
				todo: False
			end
		end

	report_execute_test_class_request (a_class_name: STRING) is
			-- Execute all tests found in class `a_class_name'.
		do
			-- TODO: implement
			check
				todo: False
			end
		end

	report_execute_test_routine_request (a_class_name, a_feature_name: STRING) is
			-- Execute test feature `a_feature_name' in class `a_class_name'.
			-- If `a_class_name' does not contain such a feature, print error message.
		local
			tc: CDD_TEST_CASE
			p: PROCEDURE [ANY, TUPLE [CDD_TEST_CASE]]
		do
			tc := test_class_instance (a_class_name)
			if tc = Void then
				report_and_set_error ("`" + a_class_name + "' is not a valid class name.")
			else
				p := test_procedure (a_class_name + "." + a_feature_name)
				if p = Void then
					report_error (a_class_name + " does not contain a test feature `" + a_feature_name + "'")
				else
					execute_test (tc, p)
				end
			end
		end

feature {NONE} -- Error handling

	report_error (a_reason: STRING) is
			-- Report error `a_reason'.
		do
			print_and_flush ("error: " + a_reason + "%N")
		end

feature {NONE} -- Control

	should_quit: BOOLEAN
			-- Should main loop quit?

feature {NONE} -- Implementation

	execute_test (a_tc: CDD_TEST_CASE; a_p: PROCEDURE [ANY, TUPLE [CDD_TEST_CASE]]) is
			-- Set up `a_tc' (via `set_up'),  call `a_p' and tear it down (via `tear_down').
			-- Print results on standard out.
		require
			a_tc_not_void: a_tc /= Void
			a_p_not_void: a_p /= Void
		local
			l_tuple: TUPLE [CDD_TEST_CASE]
		do
			execute_protected (agent a_tc.set_up)
			if last_protected_execution_successfull then
				l_tuple := a_p.empty_operands
				check l_tuple.valid_type_for_index (a_tc, 1) end
				l_tuple.put (a_tc, 1)
				a_p.set_operands (l_tuple)
				execute_protected (a_p)
				execute_protected (agent a_tc.tear_down)
			end
			print_line_and_flush ("done:")
		end

	execute_protected (procedure: PROCEDURE [ANY, TUPLE]) is
			-- Execute `procedure' in a protected way.
		local
			failed: BOOLEAN
			l_exception: INTEGER
			l_recipient_name: STRING
			l_class_name: STRING
			l_tag_name: STRING
			l_meaning: STRING
			l_exception_trace: STRING
		do
			last_protected_execution_successfull := False
			if not failed then
				print_multi_line_value_start_tag
				procedure.apply
				print_multi_line_value_end_tag
				print_and_flush ("status: success%N")
				last_protected_execution_successfull := True
			end
		rescue
			failed := True
			print_multi_line_value_end_tag
			l_exception := exception
			l_tag_name := tag_name
			l_recipient_name := recipient_name
			l_class_name := class_name
			if l_class_name = Void then
					-- Arno: fix for the case of invariants where we
					-- currently are not able to retreive a class name
				l_class_name := "NONE"
			end
			l_meaning := meaning (l_exception)
			l_exception_trace := exception_trace

			if l_recipient_name = Void then
				l_recipient_name := ""
			end
			check
				l_class_name_not_void: l_class_name /= Void
			end
			if l_tag_name = Void then
				l_tag_name := ""
			end
			if l_meaning = Void then
				l_meaning := ""
			end
			print_line_and_flush ("status: exception")
			print_line_and_flush (l_exception.out)
			print_line_and_flush (l_recipient_name)
			print_line_and_flush (l_class_name)
			print_multi_line_value_start_tag
			print_line_and_flush (l_tag_name)
			print_multi_line_value_end_tag
			print_multi_line_value_start_tag
			print_line_and_flush (l_exception_trace)
			print_multi_line_value_end_tag
			retry
		end

	last_protected_execution_successfull: BOOLEAN
			-- Was the last protected execution successfull?
			-- (i.e. did it not trigger an exception)

feature {NONE} -- Output

	print_and_flush (a_text: STRING) is
			-- Print `a_text' and flush output stream.
		require
			a_text_not_void: a_text /= Void
		do
			print (a_text)
			io.output.flush
		end

	print_line_and_flush (a_text: STRING) is
			-- Print `a_text' followed by a newline and flush output stream.
		require
			a_text_not_void: a_text /= Void
		do
			print (a_text)
			io.output.put_new_line
			io.output.flush
		end

	print_multi_line_value_start_tag is
			-- Print the start tag for a multi line value.
		do
			print_and_flush (multi_line_value_start_tag)
			print_and_flush ("%N")
		end

	print_multi_line_value_end_tag is
			-- Print the start tag for a multi line value.
		do
			print_and_flush (multi_line_value_end_tag)
			print_and_flush ("%N")
		end

feature {NONE} -- Constants

	multi_line_value_start_tag: STRING is "---multi-line-value-start---"
			-- Multi line start tag

	multi_line_value_end_tag: STRING is "---multi-line-value-end---"
			-- Multi line end tag

end
