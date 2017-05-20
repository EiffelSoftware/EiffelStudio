note
	description: "Objects that test a given class and send results to the GUI using sockets, update NET_UNIT_TEST when you update this class."
	author: "Software Engineering Lab, York University"

deferred class
	ES_TEST

inherit
	ES_TESTABLE

feature -- Basic operations

	add_boolean_case (v: PREDICATE)
			-- Add boolean function `v`.
		require
			v_valid: v /= Void
		do
			if cases = Void then
				initialize
			end
			if attached cases as cases1 then
				cases1.extend (create {ES_BOOLEAN_TEST_CASE}.make ("", v))
			end
		end

	add_violation_case_with_tag (expected_tag: STRING_8; v: PROCEDURE)
			-- Add boolean function `v`.
		require
			v_valid: v /= Void
		do
			if cases = Void then
				initialize
			end
			if attached cases as cases1 then
				cases1.extend (create {ES_VIOLATION_CASE}.make_with_tag ("", v, expected_tag))
			end
		end

	add_violation_case (v: PROCEDURE)
			-- Add boolean function `v`.
		require
			v_valid: v /= Void
		do
			if cases = Void then
				initialize
			end
			if attached cases as cases1 then
				cases1.extend (create {ES_VIOLATION_CASE}.make ("", v))
			end
		end

feature {NONE} -- setup and teardown

	setup
			-- Will be executed at the beginning of "run" in a test case.
		do
		end

	teardown
			-- Will be executed at the end of "run" in a test case.
		do
		end

	comment (s: STRING_8)
			-- Adds `s' to descriptions.
		do
			class_variable_comment_string := s
		end

	html_start_code: STRING = "<br><code>"
	html_end_code: STRING = "</code>"
	space: STRING = "&nbsp"

	sub_comment (s: STRING_8)
			-- Adds `s' to comments.
		do
			class_variable_comment_string.append ("%N" + s)
		end

	assert_equal(a_name: STRING; expected, actual: detachable ANY)
		local
			l_line1, l_line2, l_line3: STRING
			expected_out, actual_out: STRING
			cv: CHECK_VIOLATION
		do

			if expected /~ actual then
				if expected /= Void then
					expected_out := expected.out
				else
					expected_out := "Void"
				end
				if actual /= Void then
					actual_out := actual.out
				else
					actual_out := "Void"
				end
				l_line1 := html_start_code + "Assert Equal Violation: " + a_name + html_end_code
				l_line2 := html_start_code + "Expected: " + expected_out + html_end_code
				l_line3 := html_start_code + "Actual:&nbsp&nbsp&nbsp" + actual_out + html_end_code
				class_variable_comment_string.append (l_line1 + l_line2 + l_line3)
				create cv
				cv.set_description (a_name)
				cv.raise
			end
		end

		assert_not_equal(a_name: STRING; expected, actual: detachable ANY)
			local
				l_line1, l_line2, l_line3: attached STRING
				expected_out, actual_out: STRING
				cv: CHECK_VIOLATION
			do
				if  expected ~ actual then
					if expected /= Void then
						expected_out := expected.out
					else
						expected_out := "Void"
					end
					if actual /= Void then
						actual_out := actual.out
					else
						actual_out := "Void"
					end
					l_line1 := html_start_code + "Assert NOT Equal Violation: " + a_name + html_end_code
					l_line2 := html_start_code + "Expected: " + expected_out + html_end_code
					l_line3 := html_start_code + "Actual:&nbsp&nbsp&nbsp" + actual_out + html_end_code
					class_variable_comment_string.append (l_line1 + l_line2 + l_line3)
					create cv
					cv.set_description (a_name)
					cv.raise
				end
			end

		assert(a_name: STRING; condition: BOOLEAN; actual: detachable ANY)
			local
				l_line1, l_line2: attached STRING
				actual_out: STRING
				cv: CHECK_VIOLATION
			do
				if  not condition then
					if actual /= Void then
						actual_out := actual.out
					else
						actual_out := "Void"
					end
					l_line1 := html_start_code + "Assert Violation: " + a_name + html_end_code
					l_line2 := html_start_code + "Object:&nbsp&nbsp&nbsp" + actual_out + html_end_code
					class_variable_comment_string.append (l_line1 + l_line2)
					create cv
					cv.set_description (a_name)
					cv.raise
				end
			end

feature {ES_SUITE}

	failed_cases: LIST [STRING]
		local
			failed: ARRAYED_LIST [STRING]
			unkn: CELL [INTEGER]
		do
			create failed.make (10)
			create unkn.put (0)
			if attached cases as cases1 then
				across cases1 as it loop
					create_case_name (it.item, unkn)
					if not it.item.passed then
						failed.extend (case_name)
					end
				end
			end
			Result := failed
		end

	create_case_name (case: ES_TEST_CASE; unkn: CELL [INTEGER])
		local
			ls: LIST [STRING]
		do
			ls := case.case_name.split (':')
			if not case.case_name.has (':') or ls.is_empty then
				unkn.put (unkn.item + 1)
				case_name := "unknown_" + unkn.item.out + " -- use ':' in a `comment' in the test case"
			else
				case_name := ls.first
			end
			if attached name as n then
				case_name := n + "." + case_name
			end
		end

	case_name: STRING
		attribute
			Result := ""
		end

	passed_cases: LIST [STRING]
		local
			success: ARRAYED_LIST [STRING]
			unkn: CELL [INTEGER]
		do
			create success.make (10)
			create unkn.put (0)
			if attached cases as cases1 then
				across cases1 as it loop
					create_case_name (it.item, unkn)
					if it.item.passed then
						success.extend (case_name)
					else
						-- do nothing
					end
				end
			else
				-- do nothing
			end
			Result := success
		end

	count: INTEGER_32
			-- Number of test cases in `Current'.
		do
			check attached cases as cases1 then
				Result := cases1.count
			end
		end

	initialize
			-- Initialize Current.
		do
			create cases.make
			name := generating_type.name
			create descriptions.make
		end

	to_html (output_file_name: STRING_8)
			-- Generate HTML report with details.
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
			-- Get unit test name.
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
			-- Run tests in cases.
		local
			problem: BOOLEAN
			last_index: INTEGER_32
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
					if show_err then
						check
							attached cases1.item as item1
							attached item1.exception_trace as et
						then
							safe_put_string ("%N" + et + "%N")
						end
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
			-- Text represenation of a test case.
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

	class_variable_comment_string: STRING_8
		attribute
			Result := ""
		end

end
