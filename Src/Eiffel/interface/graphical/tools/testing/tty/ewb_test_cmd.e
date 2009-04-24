note
	description: "[
		Common functionality shared between TTY testing commands .
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EWB_TEST_CMD

inherit
	EWB_CMD

	TEST_SUITE_OBSERVER
		redefine
			on_processor_error
		end

	SHARED_TEST_SERVICE
		redefine
			on_processor_launch_error
		end

feature -- Basic operations

	execute
			-- <Precursor>
		local
			l_service: TEST_SUITE_S
		do
			if test_suite.is_service_available then
				l_service := test_suite.service
				if l_service.is_interface_usable then
					if l_service.is_project_initialized then
						execute_with_test_suite (l_service)
					else
						print_string (locale.translation (e_test_suite_not_initialized))
						print_string ("%N")
					end
				else
					print_string (locale.translation (e_test_suite_not_usable))
					print_string ("%N")
				end
			end
		end

feature {NONE} -- Access

	filtered_tests (a_test_suite: attached TEST_SUITE_S): attached TAG_BASED_FILTERED_COLLECTION [attached TEST_I]
			-- Currently active filtered collection of tests in `test_suite' service.
		require
			test_suite_usable: a_test_suite.is_interface_usable
			test_suite_initialized: a_test_suite.is_project_initialized
		local
			l_cache: detachable like filtered_tests
		do
			l_cache := filtered_tests_cell.item
			if l_cache = Void or else
			   not l_cache.is_interface_usable or else
			   not l_cache.is_connected or else
			   l_cache.collection /= a_test_suite
			then
				create l_cache.make
				l_cache.connect (a_test_suite)
				filtered_tests_cell.put (l_cache)
			end
			Result := l_cache
		ensure
			result_attached: Result /= Void
			result_usable: Result.is_interface_usable
			result_connected: Result.is_connected
			result_uses_test_suite: Result.collection = a_test_suite
		end

	tree_view (a_test_suite: attached TEST_SUITE_S): attached TAG_BASED_TREE [attached TEST_I]
		require
			test_suite_usable: a_test_suite.is_interface_usable
			test_suite_initialized: a_test_suite.is_project_initialized
		local
			l_cache: detachable like tree_view
		do
			l_cache := tree_view_cell.item
			if l_cache = Void or else
			   not l_cache.is_interface_usable or else
			   not l_cache.is_connected or else
			   l_cache.collection /= filtered_tests (a_test_suite)
			then
				create l_cache.make
				l_cache.connect (filtered_tests (a_test_suite), default_tag_prefix)
				tree_view_cell.put (l_cache)
			end
			Result := l_cache
		ensure
			result_attached: Result /= Void
			result_usable: Result.is_interface_usable
			result_connected: Result.is_connected
			result_uses_filtered_tests: Result.collection = filtered_tests (a_test_suite)
		end

	filtered_tests_cell: CELL [detachable TAG_BASED_FILTERED_COLLECTION [attached TEST_I]]
			-- Cache for `filtered_tests'
		once
			create Result.put (Void)
		ensure
			result_attached: Result /= Void
		end

	tree_view_cell: CELL [detachable TAG_BASED_TREE [attached TEST_I]]
			-- Cache for `tree_view'
		once
			create Result.put (Void)
		ensure
			result_attached: Result /= Void
		end

	default_tag_prefix: STRING = "class"
			-- Default tag prefix for `tree_view'

feature {NONE} -- Query

	outcome (a_test: TEST_I): READABLE_STRING_8
			-- String representation for the current outcome of `a_test'
		do
			if a_test.is_outcome_available then
				inspect a_test.last_outcome.status
				when {EQA_TEST_RESULT_STATUS_TYPES}.passed then
					Result := "passes"
				when {EQA_TEST_RESULT_STATUS_TYPES}.failed then
					Result := "FAIL"
				else
					Result := "unresolved"
				end
			else
				Result := "[untested]"
			end
		ensure
			result_attached: Result /= Void
			result_not_empty: not Result.is_empty
			result_not_too_long: Result.count <= max_outcome_count
		end

feature {NONE} -- Basic operations

	print_string (a_string: READABLE_STRING_8)
		require
			a_string_attached: a_string /= Void
		do
			command_line_io.localized_print (a_string.string)
		end

	print_statistics (a_test_suite: attached TEST_SUITE_S; a_include_filter: BOOLEAN)
		require
			a_test_suite_usable: a_test_suite.is_interface_usable
			a_test_suite_initialized: a_test_suite.is_project_initialized
		local
			l_total, l_executed, l_failing, l_passing, l_unresolved, l_filtered: NATURAL
			l_translated: STRING_GENERAL
		do
			l_total := a_test_suite.tests.count.to_natural_32
			l_filtered := filtered_tests (a_test_suite).items.count.to_natural_32
			l_executed := a_test_suite.count_executed
			l_passing := a_test_suite.count_passing
			l_failing := a_test_suite.count_failing
			l_unresolved := l_executed - l_passing - l_failing
			if a_include_filter and l_filtered /= l_total then
				l_translated := locale.translation (m_filter_statistics)
			else
				l_translated := locale.translation (m_statistics)
			end
			print_string ("%N")
			print_string (locale.formatted_string (l_translated,
				[l_total, l_filtered, l_executed, l_passing, l_failing, l_unresolved]))
			print_string ("%N%N")
		end

	print_multiple_string (a_string: READABLE_STRING_8; a_count: INTEGER)
		require
			a_count_not_negative: a_count >= 0
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > a_count
			loop
				print_string (a_string)
				i := i + 1
			end
		end

	print_current_expression (a_test_suite: attached TEST_SUITE_S; a_force: BOOLEAN)
			-- Print current expression in `filtered_tests'.
			--
			-- `a_test_suite': Current test suite service
			-- `a_force': True if expression should be printed even if it is empty.
		local
			l_filter: like filtered_tests
		do
			l_filter := filtered_tests (a_test_suite)
			if a_force or l_filter.has_expression then
				print_string (locale.translation (m_current_filter))
				if l_filter.has_expression then
					print_string (l_filter.expression)
				end
				print_string ("%N")
			end
		end

	print_current_prefix (a_test_suite: attached TEST_SUITE_S; a_force: BOOLEAN)
			-- Print current tag prefix for `tree_view'.
			--
			-- `a_test_suite': Current test suite service.
			-- `a_force': True if tag prefix should be printed even if empty.
		local
			l_view: like tree_view
		do
			l_view := tree_view (a_test_suite)
			if a_force or not l_view.tag_prefix.is_empty then
				print_string (locale.translation (m_current_prefix))
				print_string (l_view.tag_prefix)
				print_string ("%N")
			end
		end

	print_test (a_test: attached TEST_I; a_prefix: attached READABLE_STRING_8; a_tab_count: INTEGER)
			-- Print information for given test.
			--
			-- `a_test': Test for which information should be printed.
			-- `a_prefix': String which will be printed before the test name.
			-- `a_tab_count': Tabulator count for outcome row following test name.
		require
			a_test_attached: a_test /= Void
			a_tab_count_valid: a_tab_count >= -1
		local
			l_name: STRING
			l_count: INTEGER
		do
			l_count := a_test.name.count + a_prefix.count
			create l_name.make (l_count)
			l_name.append (a_prefix)
			l_name.append (a_test.name)

			if a_tab_count = -1 then
				print_string (" ")
				print_string (l_name)
			elseif a_tab_count > 4 or l_count < a_tab_count then
				if l_count >= a_tab_count then
					print_string (l_name.substring (1, a_tab_count - 4))
					print_string ("... ")
				else
					print_string (l_name)
					print_multiple_string (" ", a_tab_count - l_count)
				end
			else
				print_multiple_string (" ", a_tab_count)
			end

			print_string (outcome (a_test))
			print_string ("%N")
		end

feature {NONE} -- Events

	on_processor_error (a_test_suite: attached TEST_SUITE_S; a_processor: attached TEST_PROCESSOR_I; a_error: attached STRING_8; a_token_values: TUPLE)
			-- <Precursor>
		do
			print_string (locale.formatted_string (a_error, a_token_values))
			print_string ("%N")
		end

	on_processor_launch_error (a_error: like error_message; a_type: attached TYPE [TEST_PROCESSOR_I]; a_code: NATURAL_32)
			-- <Precursor>
		do
			print_string (a_error)
			print_string ("%N%N")
		end

feature {NONE} -- Implementation

	launch_ewb_processor (a_test_suite: TEST_SUITE_S; a_type: attached TYPE [TEST_PROCESSOR_I]; a_conf: attached TEST_PROCESSOR_CONF_I)
			-- Launch test suite processor.
		require
			a_test_suite_usable: a_test_suite.is_interface_usable
		do
			a_test_suite.test_suite_connection.connect_events (Current)
			launch_processor (a_type, a_conf)
			a_test_suite.test_suite_connection.disconnect_events (Current)
		end

	execute_with_test_suite (a_test_suite: attached TEST_SUITE_S)
		require
			test_suite_usable: a_test_suite.is_interface_usable
			test_suite_initialized: a_test_suite.is_project_initialized
		deferred
		end

feature {NONE} -- Constants

	max_outcome_count: INTEGER = 10
			-- Max length for `outcome'

	tab_count: INTEGER = 65

feature {NONE} -- Internationalization

	m_current_filter: STRING = "Current filter: "
	m_current_prefix: STRING = "Current tag prefix: "

	m_statistics: STRING = "$1 tests total ($3 executed, $5 failing, $6 unresolved)"
	m_filter_statistics: STRING = "$2 of $1 tests shown ($3 executed, $5 failing, $6 unresolved)"
			-- $1: Total number of tests
			-- $2: Number of tests after filtering
			-- $3: Number of tests executed (total)
			-- $4: Number of tests passing (total)
			-- $5: Number of tests failing (total)
			-- $6: Number of tests unresolved (total)

	e_test_suite_not_initialized: STRING = "Test suite has not been initialized yet. Please compile project."
	e_test_suite_not_usable: STRING = "The test suite service is currently unavailable."

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
