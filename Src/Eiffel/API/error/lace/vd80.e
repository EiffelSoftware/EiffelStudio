note
	description: "General configuration warning"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	VD80

inherit
	LACE_WARNING
		redefine
			build_explain, print_single_line_error_message
		end;

feature -- Properties

	warning: CONF_ERROR;
			-- Warning

feature -- Output

	build_explain (st: TEXT_FORMATTER)
		do
				-- No need to add a line, there is already one inserted by `print_short_help'.
			st.add (warning.out)
			st.add_new_line;
		end;

feature {NONE} -- Output

	print_single_line_error_message (a_text_formatter: TEXT_FORMATTER)
			-- Displays single line help in `a_text_formatter'.
		local
			l_text: STRING_8
			l_lines: LIST [STRING_8]
		do
			Precursor (a_text_formatter)

			l_text := warning.out
			l_text.prune_all_trailing ('%N')
			l_lines := l_text.split ('%N')
			if not l_lines.is_empty then
				l_text := l_lines.last
				a_text_formatter.add_space
				a_text_formatter.add (l_text)
			end
		end

feature {SYSTEM_I, LACE_I} -- Setting

	set_warning (s: like warning)
			-- Assign `s' to `warning'
		do
			warning := s
		end;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
