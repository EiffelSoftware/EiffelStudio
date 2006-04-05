indexing
	description: "Sends compiler error output to a pipe"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	COM_PIPED_OUTPUT_WINDOW
	
inherit
	OUTPUT_WINDOW
	
create
	make
	
feature {NONE} -- Initialization

	make (a_pipe: WEL_PIPE) is
			-- create error displayer for piped output
		require
			non_void_pipe: a_pipe /= Void
			input_open: not a_pipe.input_closed
		do
			input_pipe := a_pipe
		end
		
feature -- Output

	put_string (s: STRING) is 
		do 
			input_pipe.put_string (s)
		end

	new_line, put_new_line is 
		do 
			input_pipe.put_string ("%N")
		end

	put_char (c: CHARACTER) is 
		local
			l_char_string: STRING
		do 
			create l_char_string.make_empty
			l_char_string.append_character (c)
			put_string (l_char_string) 
		end		
		
feature {NONE} -- Implementation

	input_pipe: WEL_PIPE
	
invariant
	non_void_intput_pipe: input_pipe /= Void
	input_pipe_open: not input_pipe.input_closed

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
end -- class COM_PIPED_OUTPUT_WINDOW
