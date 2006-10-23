indexing
	description: "Syntax error."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class
	SYNTAX_ERROR

inherit
	ERROR

create {ERROR_HANDLER}
	init

create
	make

feature {NONE} -- Initialization

	make (s, e: INTEGER; f: STRING; m: STRING; u: BOOLEAN) is
			-- Create a new SYNTAX_ERROR.
		require
			f_not_void: f /= Void
			m_not_void: m /= Void
		do
			line := s
			column := e
			file_name := f
			error_message := m
		ensure
			line_set: line = s
			column_set: column = e
			file_name_set: file_name = f
			error_message_set: error_message = m
		end

	init is
			-- Dummy implementation, kept for backward compatibility.
		do
			file_name := ""
			error_message := ""
		end

feature -- Access

	line: INTEGER
			-- Line number

	column: INTEGER
			-- Column number

	file_name: STRING
			-- File name containing text with syntax error

	error_message: STRING
			-- Syntax error message

feature {NONE} -- Implementation

	syntax_message: STRING is
			-- Syntax error message, kept for backward compatibility.
		do
			Result := error_message
		end

invariant
	attached_file_name: file_name /= Void
	attached_error_message: error_message /= Void

indexing
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

end -- class SYNTAX_ERROR
