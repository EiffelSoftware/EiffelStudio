note
	description: "Objects that represent bunch of ES_TESTs (unit tests)."
	author: "Software Engineering Lab, York University"

class
	ES_SUITE

inherit
	ES_TESTABLE

feature -- Basic Operations

	add_test (unit_test_class: ES_TEST)
			-- Adds class level test `unit_test_class' to Current test suite
			-- use this feature to add your unit test classes to the suite.
		require
			unit_tests_class_exists: unit_test_class /= Void
		local
			c: like classes
		do
			c := classes
			if not attached c then
				create c.make
				classes := c
				name := generating_type.name.twin.as_string_8
			end
			c.extend (unit_test_class)
		end

	add_suite (suite_test_class: ES_SUITE)
			-- Adds a suite of tests to the current suite.
		require
			suite_test_class_exists: suite_test_class /= Void
		do
			if attached suite_test_class.classes as c then
				across
					c as t
				loop
					add_test (t.item)
				end
			end
		end

feature {ES_TEST} -- Implementation

	to_html (output_file_name: STRING_8)
			-- Generate HTML report with details.
		require
			output_file_name_valid: output_file_name /= Void
		local
			gen: ES_HTML_GEN_SUITE
		do
			check
				attached classes as cl
			then
				check
					attached name as n
				then
					create gen.make (n, output_file_name, cl, show_err)
				end
			end
		end

	run_es_test
			-- Run es-test in suite mode.
		do
			if attached classes as classes1 then
				number_of_tests := 0
				number_passed_tests := 0
				from
					classes1.start
				until
					classes1.after
				loop
					check
						attached classes1.item as item1
					then
						if show_err then -- if show error is set at the suite level, then show errors in all
							item1.set_error_report (show_err)
						end
						item1.run_es_test
						number_of_tests := number_of_tests + item1.number_of_tests
						number_passed_tests := number_passed_tests + item1.number_passed_tests
						classes1.forth
					end
				end
				to_html (get_html_name)
				check_browser
			else
				print_to_screen ("Error: No test cases added%N")
			end
		end

	passed_cases: LIST [STRING]
		do
			create {ARRAYED_LIST [STRING]} Result.make (10)
			if attached classes as classes1 then
				across classes1 as it loop
					Result.append (it.item.passed_cases)
				end
			end
		end

	failed_cases: LIST [STRING]
		do
			create {ARRAYED_LIST [STRING]} Result.make (10)
			if attached classes as classes1 then
				across classes1 as it loop
					Result.append (it.item.failed_cases)
				end
			end
		end

	make_test (v: BOOLEAN)
			-- Initialize Current.
		do
			show_err := v
			name := "default_name"
		end

	count: INTEGER_32
			-- Number of tests in `Current'.
		do
			check
				attached classes as classes1
			then
				Result := classes1.count
			end
		end

	pass_values(e: BOOLEAN; b: BOOLEAN; n: like name)
		do
			show_err := e
			browser := b
			name := n
		end

feature {ES_SUITE, ES_SUITE}

	name: detachable STRING_8

	classes: detachable LINKED_LIST [ES_TEST]

end
