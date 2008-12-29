note
	description: "Output windows for use within compiler for redirecting to a stream"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	OUTPUT_WINDOW_STREAM

inherit
	OUTPUT_WINDOW

create
	make

feature {NONE} -- Initialization

	make (a_file: like file_stream)
			-- Initialize output window with file `a_file'
		require
			a_file_attached: a_file /= Void
			a_file_is_open_write: a_file.is_open_write
		do
			file_stream := a_file
		ensure
			file_stream_set: file_stream = a_file
		end

feature -- Output

	put_string (s: STRING)
		do
			file_stream.put_string (s)
		end

	put_new_line
		do
			file_stream.put_new_line
		end

	put_char (c: CHARACTER)
		do
			file_stream.put_character (c)
		end

feature {NONE} -- Implementation

	file_stream: FILE
			-- Ouptut file stream used to set output information to

invariant
	file_stream_attached: file_stream /= Void
	file_stream_is_open_write: file_stream.is_open_write

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

end -- class {OUTPUT_WINDOW_STREAM}
