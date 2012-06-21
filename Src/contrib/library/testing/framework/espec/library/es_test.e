note
	description: "Objects that test a given class and send results to the GUI using sockets, update NET_UNIT_TEST when you update this class"
	author: "Software Engineering Lab, York University"

deferred class
	ES_TEST

inherit
	ES_TESTABLE

feature -- Basic Operations

	add_boolean_case (v: FUNCTION [ANY, TUPLE, BOOLEAN])
			-- Add boolean function v
		require
			v_valid: v /= Void
		local
			b: ES_BOOLEAN_TEST_CASE
		do
			if cases = Void then
				initialize
			end

			if attached cases as cases1 then
				create b.make ("", v)
				cases1.extend (b)
			end
		end

	add_violation_case_with_tag (expected_tag: STRING_8; v: PROCEDURE [ANY, TUPLE])
			-- Add boolean function v
		require
			v_valid: v /= Void
		local
			b: ES_VIOLATION_CASE
		do
			if cases = Void then
				initialize
			end

			if attached cases as cases1 then
				create b.make_with_tag ("", v, expected_tag)
				cases1.extend (b)
			end
		end

	add_violation_case (v: PROCEDURE [ANY, TUPLE])
			-- Add boolean function v
		require
			v_valid: v /= Void
		local
			b: ES_VIOLATION_CASE
		do
			if cases = Void then
				initialize
			end

			if attached cases as cases1 then
				create b.make ("", v)
				cases1.extend (b)
			end
		end

feature {NONE} -- setup and teardown

	setup
			-- will be executed at the beginning of "run" in a test case
		do
		end

	teardown
			-- will be executed at the end of "run" in a test case
		do
		end

	comment (s: STRING_8)
			-- Adds `s' to descriptions
		do
			class_variable_comment_string := s
		end


feature {ES_SUITE}
	count: INTEGER_32
			-- number of test cases in `Current'
		do
			check attached cases as cases1 then
				Result := cases1.count
			end
		end

	initialize
			-- Initialize Current
		do
			create cases.make
			name := generating_type.name
			create descriptions.make
		end

	to_html (output_file_name: STRING_8)
			-- generate HTML report with details
		require
			output_file_name_valid: output_file_name /= Void
		local
			gen: ES_SUITE
		do
			create gen
			gen.add_test (Current)
			gen.pass_values(show_err, browser, name)
			gen.to_html (output_file_name)
		end

	get_test_name: STRING_8
			-- get unit test name
		do
			if name /= Void then
				check attached name as n then
					Result := n
				end
			else
				Result := "default_name"
			end
		end

	run_es_test
			-- run tests in cases
		local
			problem: BOOLEAN
			last_index: INTEGER_32
			printed_once: BOOLEAN
		do
			if attached cases as cases1 then
				if not problem then
					number_of_tests := 0
					number_passed_tests := 0
					check attached get_test_name as test_name then
						safe_put_string (test_name + "%N")
					end
				else
					safe_put_string ("***FAILED                   Problem in 'setup' or 'teardown' features%N")
					if not printed_once then
						check attached cases1.item as item1 then
							if show_err then
								check attached item1.exception_trace as et then
									safe_put_string ("%N" + et.twin + "%N")
								end
							end
						end
						printed_once := True
					end
				end
				from
					if not problem then
						cases1.start
					else
						if cases1.valid_cursor_index (last_index) then
							cases1.go_i_th (last_index)
						end
					end
				until
					cases1.after
				loop
					class_variable_comment_string := "no comment"
					setup
					check attached cases1.item as item1 then
						item1.run
						teardown
						check attached class_variable_comment_string as cvc then
							item1.set_case_name (cvc)
						end
						check attached to_message_string (item1) as ms then
							safe_put_string (ms + "%N")
						end
						number_of_tests := number_of_tests + 1
						if item1.passed then
							number_passed_tests := number_passed_tests + 1
						end
					end
					cases1.forth
				end
			else
				-- do nothing
			end
			to_html (get_html_name)
			check_browser
		rescue
			check attached cases as cases1 then
				problem := True
				cases1.forth
				last_index := cases1.index
				retry
			end
		end


	to_message_string (item: ES_TEST_CASE): STRING_8
			-- text represenation of a test case
		require
			arg_not_void: item /= Void
		do
			check attached cases as cases1 then
				create Result.make_empty
				if item.passed then
					Result.append_string ("   PASSED   ")
				else
					Result.append_string ("***FAILED   ")
				end
				check attached cases1.item as item1 then
					if item.contract_violated then
						check attached item1.meaning (item1.violation_type) as meaning then
							Result.append_string ("VIOL      " + "#" + meaning + "#")
						end
					else
						Result.append_string ("NO VIOL   ")
					end
					Result.append_string (item1.case_name)
					if show_err then
						check attached item1.violation_tag as tag then
							Result.append_string ("%N" + tag)
						end
					end
				end
			end
		ensure
			result_not_void: Result /= Void
			result_not_empty: not Result.is_empty
		end

feature {ES_HTML_GEN_SUITE} --test cases

	cases: detachable LINKED_LIST [ES_TEST_CASE]

	name: detachable STRING_8

	descriptions: detachable LINKED_LIST [STRING_8]

	class_variable_comment_string: detachable STRING_8


end -- class ES_TEST

