indexing
	description: "Object that stores a block of data into a STRING object"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PROCESS_IO_STRING_BLOCK

inherit
	EB_PROCESS_IO_DATA_BLOCK

create
	make

feature{NONE} -- Initialization

	make (str: STRING; from_error: BOOLEAN; is_last_one: BOOLEAN) is
			-- Store `str' into `Current' object.
			-- `from_error' indicates whether `str' comes from error stream
			-- from process.
		require
			str_not_void: str /= Void
		do
			is_error := from_error
			is_end := is_last_one
			create string_buffer.make_from_string (str)
			string_buffer.replace_substring_all ("%R", "")
		ensure
			is_error_set: is_error = from_error
			is_end_set: is_end = is_last_one
			string_buffer_filtered: not string_buffer.has ('%R')
		end

feature  -- Status reporting

	data: ANY is
			--
		do
			Result := string_buffer
		end

	string_representation: STRING is
			--
		do
			Result := string_buffer
		end

	count: INTEGER is
		-- Length of stored data in bytes.
		do
			Result := string_buffer.count
		end


feature{NONE} -- Implementation

	string_buffer: STRING

invariant
	string_buffer_not_void: string_buffer /= Void

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
