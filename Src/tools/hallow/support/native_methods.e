indexing
	description: "[
		Native interop routines and functions.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	NATIVE_METHODS

feature -- Native methods

	frozen get_short_path_name (lpsz_long_path, lpsz_short_path: POINTER; cch_buffer: INTEGER): INTEGER is
			-- This function retrieves the handle to the specified child window's parent window.
			--
			-- `lpsz_long_path': Pointer to a null-terminated path string. The function retrieves the short form of this path
			-- `lpsz_short_path': Pointer to a buffer to receive the null-terminated short form of the path specified by lpszLongPath
			-- `cch_buffer': Size of the buffer pointed to by lpszShortPath, in TCHARs.
			-- `Result': If the function succeeds, the return value is the length, in TCHARs, of the string copied to lpszShortPath,
			--           not including the terminating null character.
		external
			"dllwin %"kernel32.dll%" signature (LPCTSTR, LPTSTR, DWORD): DWORD use <windows.h>"
		alias
			"GetShortPathNameW"
		end

	frozen sizeof_tchar: INTEGER is
			-- Size of a TCHAR in bytes.
		external
			"C macro use <windows.h>"
		alias
			"sizeof (TCHAR)"
		end

	frozen max_path: INTEGER is
			-- Maximum number of character allowed in a path
		external
			"C macro use <windows.h>"
		alias
			"MAX_PATH"
		end

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
