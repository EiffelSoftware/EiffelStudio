indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Mark Howard, AxaRosenberg"
	date: "$Date$"
	revision: "$Revision$"

class
	C_FILE

inherit
	RAW_FILE

create
	make

feature

	read_all (input_string: STRING) is
		require else
			is_readable: file_readable
		local
			l_status : INTEGER;
			str_area: ANY
		do
			if count > input_string.capacity then
				input_string.resize (count);
			end
			str_area := input_string.area
			l_status := fread ($str_area, 1, count,file_pointer)
			input_string.set_count (l_status);
		end

	fread (l_string: POINTER; l_size: INTEGER; l_count: INTEGER; l_file: POINTER): INTEGER is
		external
			"C [macro %"stdio.h%"] (void *, size_t, size_t, FILE *): EIF_INTEGER"
		end

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

end -- class C_FILE
