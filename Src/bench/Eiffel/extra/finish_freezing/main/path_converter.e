indexing
	description: "Convert path string formats to DOS 8.3 length filename conventions."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "08/29/02"
	revision: "$Revision$"

class
	PATH_CONVERTER

feature -- Access

	eiffel_dir: STRING
			-- EIFFEL installation environment variable

	Max_path_length: INTEGER is 1024
			-- Maximum path length (in characters)
			--| Windows limit.

	short_path (long_path: STRING): STRING is
			-- Short path name corresponding to `long_path'.
		require
			non_void_long_path: long_path /= Void
			valid_long_path: not long_path.is_empty
		local
			a1, a2: WEL_STRING
			ret: INTEGER
		do
			create a1.make (long_path)
			create a2.make_empty (Max_path_length)
			ret := convert_path (a1.item, a2.item, Max_path_length)
			if ret > 0 and ret <= Max_path_length then
				Result := a2.string
			else
				Result := long_path
			end
		ensure
			non_void_short_path: Result /= Void
			valid_short_path: not Result.is_empty
		end

feature {NONE} -- Externals

	convert_path (a1, a2: POINTER; sz: INTEGER): INTEGER is
			-- Convert a long path name to a short path name.
		external
			"C signature (LPCTSTR, LPTSTR, DWORD): DWORD use <windows.h>"
		alias
			"GetShortPathName"
		end

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

end -- class PATH_CONVERTER
