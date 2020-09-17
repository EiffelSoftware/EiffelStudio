note
	description: "Syntax error."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SYNTAX_ERROR

inherit
	ERROR
		redefine
			has_associated_file
		end

create
	make, init

feature {NONE} -- Initialization

	make (l, c: INTEGER; f: like file_name; m: READABLE_STRING_32)
			-- Create a new SYNTAX_ERROR.
		require
			f_not_void: f /= Void
			m_not_void: m /= Void
		do
			set_position (l, c)
			file_name := f
			error_message := m
		ensure
			line_set: line = l
			column_set: column = c
			file_name_set: file_name = f
			error_message_set: error_message = m
		end

	init (a_parser: EIFFEL_PARSER)
			-- Initialize `line' and `column' from `a_parser'.
		require
			a_parser_not_void: a_parser /= Void
		do
			make (a_parser.line, a_parser.column, a_parser.filename, a_parser.error_message)
			set_associated_class (a_parser.current_class)
		end

feature -- Properties

	error_message: READABLE_STRING_32
			-- Error description.

	file_name: like {ERROR}.file_name
			-- Path to file where syntax issue happened.

	code: STRING = "Syntax Error"
			-- Error code.

	has_associated_file: BOOLEAN = True
			-- Current is associated to a file/class.

	syntax_message: STRING
			-- Specific syntax message.
			-- (By default, it is empty)
		do
			Result := ""
		ensure
			non_void_result: Result /= Void
		end

feature -- Visitor

	process (a_visitor: ERROR_VISITOR)
		do
			a_visitor.process_syntax_error (Current)
		end

invariant
	attached_file_name: file_name /= Void
	attached_error_message: error_message /= Void

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
