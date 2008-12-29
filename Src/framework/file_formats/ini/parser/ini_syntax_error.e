note
	description: "A simple syntax error found when parsing an INI text buffer."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	INI_SYNTAX_ERROR

create
	make

feature {NONE} -- Initialization

	make (a_text: like text; a_line: like line; a_column: like column)
			-- Initialize a generic sytax error with a message `a_message' on
			-- line `a_line', column position `a_column'
		require
			a_text_attached: a_text /= Void
			not_a_text_is_empty: not a_text.is_empty
			a_line_positive: a_line > 0
			a_column_positive: a_column > 0
		do
			text := a_text
			line := a_line
			column := a_column
		ensure
			text_set: text = a_text
			line_set: line = a_line
			column_set: column = a_column
		end

feature -- Access

	message: STRING
			-- Full error message
		do
			create Result.make (sytax_error_prefix.count + text.count)
			Result.append (sytax_error_prefix)
			Result.append (text)
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	line: INTEGER
			-- Error line number

	column: INTEGER
			-- Error column number

feature {NONE} -- Implementation Access

	text: STRING
			-- Syntax error text

	sytax_error_prefix: STRING = "Syntax Error: "
			-- Syntax error message prefix

invariant
	text_attached: text /= Void
	not_text_is_empty: not text.is_empty
	line_positive: line > 0
	column_positive: column > 0

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class {INI_SYNTAX_ERROR}
