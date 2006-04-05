indexing
	description: "Redirects errors to com interface"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	COM_ERROR_WINDOW

inherit
	OUTPUT_WINDOW
	
create
	make
	
feature {NONE} -- Initialization

	make (com_interface: CEIFFEL_COMPILER_COCLASS) is
			-- Initialize structure.
		require
			com_interface_exists: com_interface /= Void
		do
			interface := com_interface
			create output_string.make (0)
		end
		
feature -- Output

	put_string (s: STRING) is 
		do 
			output_string.append (s) 
		end

	new_line, put_new_line is 
		do 
			interface.event_output_string (output_string) 
			output_string.wipe_out
		end

	put_char (c: CHARACTER) is 
		do 
			output_string.append_character (c) 
		end
				
feature {NONE} -- Implementation

	interface: CEIFFEL_COMPILER_COCLASS
			-- Entity that handles messages.

	output_string: STRING;
			-- Holds output string.
	
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
end -- class COM_ERROR_WINDOW
