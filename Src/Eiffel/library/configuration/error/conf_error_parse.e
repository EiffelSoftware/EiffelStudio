indexing
	description: "Parse parse error."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ERROR_PARSE

inherit
	CONF_ERROR

create
	default_create,
	make

feature {NONE} -- Initialization

	make (a_message: STRING) is
			-- Create.
		require
			a_message_not_void: a_message /= Void
		do
			message := a_message
		end

feature -- Access

	text: STRING is
		do
			Result := "Parse error"
			if file /= Void then
				Result.append (" in "+file+" ("+row.out+":"+column.out+")")
			end
			if message /= Void then
				Result.append (": "+message)
			end
		end

feature -- Update

	set_position (a_file: like file; a_row: like row; a_column: like column) is
			-- Set position of an error.
		do
			file := a_file
			row := a_row
			column := a_column
		end

	set_message (a_message: STRING) is
			-- Set the extended error message to `a_message'.
		do
			message := a_message
		end

feature {NONE} -- Implementation

	message: STRING
	file: STRING
	row: INTEGER
	column: INTEGER;

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
end
