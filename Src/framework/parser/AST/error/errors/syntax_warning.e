indexing
	description: "Not implemented yet."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"

class
	SYNTAX_WARNING

inherit
	WARNING
		redefine
			file_name, has_associated_file
		end

	SYNTAX_MESSAGE

create
	make

feature {NONE} -- Initialization

	make (s, e: INTEGER; f: like file_name; m: STRING) is
			-- Create a new SYNTAX_WARNING instance.
		require
			f_not_void: f /= Void
			m_not_void: m /= Void
		do
			set_position (s, e)
			warning_message := m
			file_name := f
		ensure
			line_set: line = s
			column_set: column = e
			warning_message_set: warning_message = m
			file_name_set: file_name = f
		end

feature -- Properties

	warning_message: STRING
			-- Specify syntax issue message.

	file_name: STRING
			-- Path to file where syntax issue happened

	code: STRING is "Syntax Warning"
			-- Error code

	has_associated_file: BOOLEAN = True
			-- Current is associated to a file/class


invariant
	warning_message_not_void: warning_message /= Void

indexing
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

end -- class SYNTAX_WARNING
