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

	SHARED_TEST_SERVICE

feature -- Basic operations

	execute
			-- <Precursor>
		local
			l_service: TEST_SUITE_S
		do
			if test_suite.is_service_available then
				l_service := test_suite.service
				if l_service.is_interface_usable then
					execute_with_test_suite (l_service)
				else
					print_string (locale.translation (e_test_suite_not_usable))
					print_string ("%N")
				end
			end
		end

feature {NONE} -- Access

	test_tree (a_test_suite: TEST_SUITE_S): TAG_SPARSE_TREE [TEST_I]
			-- Filtered tag tree for given test suite.
			--
			-- `a_test_suite': Test suite for which a filtered tag tree should be returned.
		require
			a_test_suite_attached: a_test_suite /= Void
			a_test_suite_usable: a_test_suite.is_interface_usable
		local
			l_cache: like test_tree_cache
		do
			l_cache := test_tree_cache
			if l_cache /= Void then
				if l_cache.is_connected and then l_cache.tree /= a_test_suite.tag_tree then
					l_cache.disconnect
				end
			else
				create l_cache.make (test_tree_filter)
			end
			if not l_cache.is_connected then
				l_cache.connect (a_test_suite.tag_tree)
			end
			Result := l_cache
		ensure
			result_attached: Result /= Void
			result_connected: Result.is_connected
			result_valid: Result.tree = a_test_suite.tag_tree
			result_uses_filter: Result.filter = test_tree_filter
		end

	test_tree_cache: detachable like test_tree
			-- Cache for `test_tree'
			--
			-- Note: do not use directly, use `test_tree' instead.

	test_tree_filter: TAG_REGEX_FILTER [TEST_I]
			-- Filter used in `test_tree'
		once
			create Result.make
			Result.set_expression (default_filter_expression)
		end

feature {NONE} -- Basic operations

	print_string (a_string: READABLE_STRING_8)
		require
			a_string_attached: a_string /= Void
		do
			command_line_io.localized_print (a_string.string)
		end

	print_statistics (a_test_suite: TEST_SUITE_S)
		require
			a_test_suite_usable: a_test_suite.is_interface_usable
		local
			l_translated: STRING_GENERAL
			l_statistics: TEST_STATISTICS_I
		do
			l_statistics := a_test_suite.statistics
			l_translated := locale.translation (m_statistics)
			print_string ("%N")
			print_string (locale.formatted_string (l_translated,
				[l_statistics.test_count, 0, l_statistics.executed_test_count, 0,
					l_statistics.failing_test_count, l_statistics.unresolved_test_count]))
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

	print_test (a_test: TEST_I; a_indent: INTEGER_32)
			-- Print information for given test.
			--
			-- `a_test': Test for which information should be printed.
			-- `a_indent': Number of indentations until test is printed.
		require
			a_test_attached: a_test /= Void
		do
			print_multiple_string (indent, a_indent.to_integer_32)
			a_test.print_test (output_window)
			output_window.add_new_line
		end

feature {NONE} -- Implementation

	execute_with_test_suite (a_test_suite: TEST_SUITE_S)
		require
			test_suite_usable: a_test_suite.is_interface_usable
		deferred
		end

feature {NONE} -- Constants

	tab_count: INTEGER = 65

	indent: STRING = "    "

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
