note
	description: "Summary description for {EWB_TEST_LIST_VIEW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EWB_TEST_LIST_VIEW

inherit
	EWB_TEST_CMD

feature -- Access

	name: STRING_8 = "List view"
			-- <Precursor>

	abbreviation: CHARACTER = 'l'
			-- <Precursor>

	help_message: STRING_GENERAL
			-- <Precursor>
		do
			Result := locale.translation ("Display tests in a list")
		end

feature {NONE} -- Query

	test_map: DS_HASH_TABLE [TEST_I, like create_identifier]
			-- Map containings tests to be listed together with their id.
		require
			test_suite_available: test_suite.is_service_available
		local
			l_service: TEST_SUITE_S
			l_tests: DS_LINEAR [TEST_I]
			l_cursor: DS_LINEAR_CURSOR [TEST_I]
			l_id: like create_identifier
		do
			l_service := test_suite.service
			l_tests := l_service.tests
			create Result.make (l_tests.count)
			from
				l_cursor := l_tests.new_cursor
				l_cursor.start
			until
				l_cursor.after
			loop
				l_id := create_identifier (l_cursor.item)
				Result.force_last (l_cursor.item, l_id)
				l_cursor.forth
			end
		ensure
			result_attached: Result /= Void
			not_result_has_void: not Result.has (Void)
		end

feature {NONE} -- Basic operations

	execute_with_test_suite
			-- <Precursor>
		local
			l_map: like test_map
			l_ids: DS_ARRAYED_LIST [like create_identifier]
			l_comp: KL_COMPARABLE_COMPARATOR [like create_identifier]
			l_id: like create_identifier
		do
				-- TODO: check for test suite availability
			l_map := test_map
			create l_ids.make_from_linear (l_map.keys)
			create l_comp.make
			l_ids.sort (create {DS_QUICK_SORTER [like create_identifier]}.make (l_comp))
			from
				l_ids.start
			until
				l_ids.after
			loop
				l_id := l_ids.item_for_iteration
				print_test (l_map.item (l_id), l_id)
				l_ids.forth
			end

			print_statistics
		end

feature {NONE} -- Implementation

	print_test (a_test: TEST_I; a_id: like create_identifier)
			-- Print line containing information about a single test
			--
			-- `a_test': Test for which information should be printed
			-- `a_id': Previously create identifier for `a_test'
		do
			print_string (a_id)
			print_multiple_string (" ", column_spacing + max_identifier_count - a_id.count)
			print_string (outcome (a_test))
			print_string ("%N")
		end

feature {NONE} -- Constants

	column_spacing: INTEGER = 5
			-- Number of spaces between columns

note
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
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
