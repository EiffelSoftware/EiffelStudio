note
	description: "[
		TTY command displaying tests in a sorted list.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EWB_TEST_LIST_VIEW

inherit
	EWB_TEST_FILTER_CMD

feature -- Access

	name: STRING_8
			-- <Precursor>
		do
			Result := "List view"
		end

	abbreviation: CHARACTER
			-- <Precursor>
		do
			Result := 'l'
		end

	help_message: STRING_GENERAL
			-- <Precursor>
		do
			Result := locale.translation (h_display_list)
		end

feature {NONE} -- Basic operations

	execute_with_test_suite (a_test_suite: TEST_SUITE_S)
			-- <Precursor>
		do
			print_test_list (test_tree (a_test_suite).items, 1)
			print_statistics (a_test_suite)
		end

feature {NONE} -- Internationalization

	h_display_list: STRING = "Display tests in a list"

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
