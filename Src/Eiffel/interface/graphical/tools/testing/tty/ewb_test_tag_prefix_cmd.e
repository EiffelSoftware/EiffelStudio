note
	description: "[
		TTY command for setting the current tag prefix, used to sort tests before execution and display
		them in a tree structure.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EWB_TEST_TAG_PREFIX_CMD

inherit
	EWB_TEST_CMD

	TAG_UTILITIES
		export
			{NONE} all
		end

feature -- Access

	abbreviation: CHARACTER
			-- <Precursor>
		do
			Result := 'p'
		end

	name: STRING
			-- <Precursor>
		do
			Result := "Prefix"
		end

	help_message: STRING
			-- <Precursor>
		do
			Result := locale.translation (h_set_prefix)
		end

feature {NONE} -- Basic operations

	execute_with_test_suite (a_test_suite: TEST_SUITE_S)
			-- <Precursor>
		local
			l_view: like tree_view
			l_expr: detachable STRING
		do
			print_string (locale.translation (q_enter_prefix))
			io.read_line
			l_expr := io.last_string
			check l_expr /= Void end
			create l_expr.make_from_string (l_expr)

			l_view := tree_view (a_test_suite)
			if is_valid_tag (l_expr) then
				l_view.disconnect
				l_view.connect (filtered_tests (a_test_suite), l_expr)
			else
				print_string (l_expr)
				print_string (" is not a valid tag.")
			end
			print_current_prefix (a_test_suite, True)
		end

feature {NONE} -- Internationalization

	h_set_prefix: STRING = "Set tag prefix for tree view and execution order"
	q_enter_prefix: STRING = "Enter new tag prefix: "

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
