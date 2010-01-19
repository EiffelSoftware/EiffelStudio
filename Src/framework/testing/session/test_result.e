note
	description: "[
		Class that provides basic operations for {TEST_RESULT_I} implementations.	
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_RESULT

inherit
	TEST_RESULT_I

feature {NONE} -- Basic operations

	print_multiline_string (a_string: STRING_32; a_formatter: TEXT_FORMATTER; a_indent: NATURAL)
			-- Print given text on multiple lines respecting indentation.
			--
			-- Note: no new line character at end.
		require
			a_string_attached: a_string /= Void
			a_formatter_attached: a_formatter /= Void
		local
			l_newline: CHARACTER_32
			l_pos, l_previous: INTEGER
		do
			l_newline := '%N'
			l_pos := a_string.index_of (l_newline, 1)
			if l_pos > 0 then
				from
					l_previous := 1
				until
					l_previous > a_string.count
				loop
					if l_previous > 1 then
						a_formatter.add_new_line
					end
					a_formatter.add_indents (a_indent.to_integer_32)
					if l_pos = 0 then
						print_multiline_string (a_string.substring (l_previous, a_string.count), a_formatter, a_indent)
						l_previous := a_string.count + 1
					else
						print_multiline_string (a_string.substring (l_previous, l_pos - 1), a_formatter, a_indent)
						l_previous := l_pos + 1
						l_pos := a_string.index_of (l_newline, l_previous)
					end
				end
			else
				a_formatter.process_string_text (a_string, Void)
			end
		end

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
