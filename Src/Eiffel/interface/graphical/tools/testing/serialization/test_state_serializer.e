note
	description: "[
		Objects that (de-)serialize the results in a test suite.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_STATE_SERIALIZER

inherit
	SHARED_TEST_SERVICE

feature -- Access

	last_result: detachable ARRAYED_LIST [like serialize_result]
			-- List of results which have last been serialized

	last_error_code: NATURAL
			-- Error code describing failure of last serialization operation

feature -- Access: error codes

	no_error: like last_error_code = 0
			-- Error code indicating success

	test_suite_unavailable: like last_error_code = 1
			-- Error code for unavailable test suite

	file_not_writable: like last_error_code = 2
			-- Error code indicating that `Current' failed to write to some file

	file_not_readable: like last_error_code = 3
			-- Error code indicating that `Current' failed to read from a file

	file_not_valid: like last_error_code = 4
			-- Error code indicating that `Current' failed to read from a file becuase it did not contain
			-- valid AutoTest results

feature -- Basic operations

	serialize_test_suite
			-- Serialize all results from current test suite service and store result in `last_result'.
		do
			reset
			last_error_code := test_suite_unavailable
			perform_with_test_suite (agent (a_test_suite: TEST_SUITE_S)
				local
					l_tests: SEQUENCE [TEST_I]
					l_stats: TEST_STATISTICS_I
					l_test: TEST_I
					l_test_result: detachable TEST_RESULT_I
					l_result: like serialize_result
					l_results: like last_result
				do
					last_error_code := no_error
					l_tests := a_test_suite.tests
					l_stats := a_test_suite.statistics
					create l_results.make (l_tests.count)
					from
						l_tests.start
					until
						l_tests.after
					loop
						l_test := l_tests.item_for_iteration
						if l_stats.execution_count (l_test) > 0 then
							l_test_result := l_stats.last_result (l_test)
						else
							l_test_result := Void
						end
						l_result := serialize_result (l_test, l_test_result)
						l_results.force (l_result)
						l_tests.forth
					end
					(create {QUICK_SORTER [TEST_STATE]}.make (comparator)).sort (l_results)
					last_result := l_results
				end)
		ensure
			valid_result: last_error_code = no_error implies last_result /= Void
		end

	serialize_to_file (a_file_name: READABLE_STRING_8)
			-- Serialize results in test suite to file system and store result in `last_result'.
			--
			-- Note: even if `last_result' is not void it is still possible that serialization failed.
			--
			-- `a_file_name': Name of file in which serialization should be stored.
		local
			l_file: FILE_WINDOW
		do
			reset
			last_error_code := test_suite_unavailable
			create l_file.make (a_file_name.as_string_8)
			l_file.open_write
			if l_file.extendible then
				l_file.put_string (header_string)
				l_file.put_string (" for ")
				l_file.put_string ((create {SHARED_EIFFEL_PROJECT}).eiffel_system.name)
				l_file.put_string (" (")
				l_file.put_string ((create {DATE_TIME}.make_now).formatted_out (date_time_format))
				l_file.put_character (')')
				l_file.put_new_line
				perform_with_test_suite (agent (a_test_suite: TEST_SUITE_S; a_file: FILE_WINDOW)
					local
						l_tests: SEQUENCE [TEST_I]
						l_test: TEST_I
						l_stats: TEST_STATISTICS_I
						l_test_result: TEST_RESULT_I
						l_retried: BOOLEAN
					do
						if not l_retried then
							last_error_code := no_error

							l_tests := a_test_suite.tests
							if attached {ARRAYED_LIST [TEST_I]} l_tests as l_list then
								(create {QUICK_SORTER [TEST_I]}.make (create {AGENT_EQUALITY_TESTER [TEST_I]}.make (
									agent (a_test1, a_test2: TEST_I): BOOLEAN
										do
											Result := a_test1.name < a_test2.name
										end))).sort (l_list)
							end
							l_stats := a_test_suite.statistics
							from
								l_tests.start
							until
								l_tests.after
							loop
								l_test := l_tests.item_for_iteration
								a_file.put_string (l_test.name.as_string_8)
								if l_stats.execution_count (l_test) > 0 then
									l_test_result := l_stats.last_result (l_test)
									a_file.put_string (": ")
									l_test_result.print_result (a_file)
									a_file.put_new_line
									if not l_test_result.is_pass then
										l_test_result.print_details_indented (a_file, True, 1)
									end
								else
									a_file.put_new_line
								end
								l_tests.forth
							end
						end
					rescue
						l_retried := True
						retry
					end (?, l_file))
				else
					last_error_code := file_not_writable
				end
				if not l_file.is_closed then
					l_file.close
				end
		end

	deserialize_from_file (a_file_name: READABLE_STRING_8)
			-- Deserialize results from file system and store result in `last_result'.
			--
			-- `a_file_name': Name of file from which results should be retrieved.
		local
			l_file: PLAIN_TEXT_FILE
			l_retried: BOOLEAN
			l_results: like last_result
			l_parse: detachable like parse_test_state
			l_details, l_line: STRING
		do
			create l_file.make (a_file_name)
			if not l_retried then
				reset
				l_file.open_read
				create l_results.make (100)
				create l_details.make (4096)

				l_file.start
				if l_file.after then
					last_error_code := file_not_valid
				else
					l_file.read_line
					l_line := l_file.last_string
					if l_line.starts_with (header_string) then
						from until
							l_file.off
						loop
							l_file.read_line
							l_line := l_file.last_string
							if not (l_line.is_empty or else l_line.item (1) = '#') then
								if l_line.item (1).is_space then
									l_line.remove_head (1)
									l_details.append (l_line)
								elseif l_line.item (1) /= '#' then
									if l_parse /= Void and then attached l_parse.name as l_name then
										append_state (l_name, l_parse.tag, l_details, l_parse.is_pass, l_parse.is_fail, l_results)
										l_details.wipe_out
									end
									l_parse := parse_test_state (l_line)
								end
							end
						end
						if l_parse /= Void and then attached l_parse.name as l_name then
							append_state (l_name, l_parse.tag, l_details, l_parse.is_pass, l_parse.is_fail, l_results)
						end
							-- We bubble sort here as normally the input file is already sorted
						(create {BUBBLE_SORTER [TEST_STATE]}.make (comparator)).sort (l_results)
						last_result := l_results
					else
						last_error_code := file_not_valid
					end
				end
			end
			if not l_file.is_closed then
				l_file.close
			end
		ensure
			valid_result: last_error_code = no_error implies last_result /= Void
		rescue
			l_retried := True
			last_error_code := file_not_readable
			retry
		end

feature {NONE} -- Implementation

	reset
			-- Reset any results from last serialize operation.
		do
			last_error_code := no_error
			last_result := Void
		ensure
			error_code_reset: last_error_code = no_error
			last_result_detached: last_result = Void
		end

	serialize_result (a_test: TEST_I; l_result: detachable TEST_RESULT_I): TEST_STATE
			-- Serialize result for given test.
			--
			-- `a_test': Test for which result should be serialized.
			-- `a_result': Result to be serialized.
		require
			a_test_attached: a_test /= Void
			a_test_usable: a_test.is_interface_usable
		do
			create Result.make (a_test.name)
			if l_result /= Void then
				l_result.print_details (result_printer, True)
				Result.add_result (l_result.tag, result_printer.text, l_result.is_pass, l_result.is_fail)
				result_printer.wipe_out
			end
		end

	append_state (a_name: STRING; a_tag, a_details: detachable STRING; a_pass, a_fail: BOOLEAN; a_list: attached like last_result)
			-- Append new state to given list.
			--
			-- `a_name': Name of test for which new state should be appended.
			-- `a_tag': Tag if test was executed.
			-- `a_details': Optional test result details.
			-- `a_pass': Does associated test result pass?
			-- `a_fail': Does associated test result fail?
			-- `a_list': List to which new state should be appended.
		require
			a_name_attached: a_name /= Void
			a_list_attached: a_list /= Void
			a_name_not_empty: not a_name.is_empty
			not_pass_and_fail: not (a_pass and a_fail)
		local
			l_state: like serialize_result
		do
			create l_state.make (a_name)
			if a_tag /= Void then
				l_state.add_result (a_tag, a_details, a_pass, a_fail)
			end
			a_list.force (l_state)
		end

	parse_test_state (a_line: STRING): TUPLE [name, tag: detachable STRING; is_pass, is_fail: BOOLEAN]
			-- Parse given line to retrieve test name and state if available
		local
			a, b: INTEGER
			l_sub: STRING
		do
			Result := [Void, Void, False, False]
			from
				a := 1
				b := 0
			until
				a > a_line.count
			loop
				b := b + 1
				if b > a_line.count or else a_line.item (b).is_space then
					if a < b then
						l_sub := a_line.substring (a, b-1)
						if Result.name = Void then
								-- Remove ':' at end
							if l_sub.item (l_sub.count) = ':' then
								l_sub.remove_tail (1)
							end
							Result.name := l_sub
						elseif Result.tag = Void then
							if l_sub.is_case_insensitive_equal ("pass") then
								Result.is_pass := True
							elseif l_sub.is_case_insensitive_equal ("fail") then
								Result.is_fail := True
							end
							Result.tag := ""
						else
							if l_sub.item (1) = '(' then
								l_sub.remove_head (1)
							end
							if l_sub.item (l_sub.count) = ')' then
								l_sub.remove_tail (1)
							end
							Result.tag := l_sub
						end
					end
					a := b + 1
				end
			end
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Factory

	result_printer: TEST_RESULT_PRINTER
			-- Text formatter which prints to a string
		once
			create Result.make
		end

	comparator: COMPARABLE_COMPARATOR [TEST_STATE]
			-- Comparator for sorting `last_result'
		once
			create Result
		end

feature {NONE} -- Constants

	header_string: STRING = "# AutoTest results"
	date_time_format: STRING = "[0]mm/[0]dd/yyyy [0]hh:[0]mi"

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
