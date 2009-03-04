note
	description: "[
		TTY command for setting the expressions which currently filters tests before displaying or
		executing them.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EWB_TEST_FILTER_CMD

inherit
	EWB_TEST_CMD

feature -- Access

	abbreviation: CHARACTER
			-- <Precursor>
		do
			Result := 'f'
		end

	name: STRING
			-- <Precursor>
		do
			Result := "Filter"
		end

	help_message: STRING
			-- <Precursor>
		do
			Result := locale.translation (h_set_expression)
		end

feature {NONE} -- Basic operations

	execute_with_test_suite (a_test_suite: attached TEST_SUITE_S)
			-- <Precursor>
		local
			l_filter: like filtered_tests
			l_expr: detachable STRING
		do
			print_string (locale.translation (q_filter_expression))
			io.read_line
			l_expr := io.last_string
			check l_expr /= Void end
			create l_expr.make_from_string (l_expr)

			l_filter := filtered_tests (a_test_suite)
			if l_expr.is_empty then
				l_filter.remove_expression
			else
				l_filter.set_expression (l_expr)
			end
			print_current_expression (a_test_suite, True)
		end

feature {NONE} -- Internationalization

	h_set_expression: STRING = "Set expression for filtering tests"

	q_filter_expression: STRING = "Enter new filter expression (leave blank to remove current): "

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
