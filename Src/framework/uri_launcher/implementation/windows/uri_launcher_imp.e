note
	description: "[
		The Windows implementation of a URI launcher.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	URI_LAUNCHER_IMP

inherit
	URI_LAUNCHER_I

feature -- Basic operations

	launch (a_uri: READABLE_STRING_32): BOOLEAN
			-- <Precursor>
		local
			l_uri: WEL_STRING
			l_null: POINTER
		do
			check is_windows: {PLATFORM}.is_windows end

				-- Return value can be cast only to a 32-bit integer and a value greater than
				-- 32 represent a success, see MS documentation on ShellExecute.
			create l_uri.make (a_uri)
			Result := cwin_shell_execute (l_null, l_null, l_uri.item, l_null, l_null, cwin_sw_shownormal).to_integer_32 > 32
		end

feature {NONE} -- Externals

	cwin_shell_execute (a_hwnd: POINTER; a_operation: POINTER; a_file: POINTER; a_params: POINTER; a_directory: POINTER; a_show_cmd: INTEGER): POINTER
			-- Performs an operation on a specified file.
		external
			"C inline use <shellapi.h>"
		alias
			"return ShellExecuteW ((HWND) $a_hwnd, (LPCWSTR) $a_operation, (LPCWSTR) $a_file, (LPCWSTR) $a_params, (LPCWSTR) $a_directory, (int) $a_show_cmd);"
		end

	cwin_sw_shownormal: INTEGER
			-- Activates and displays a window. If the window is minimized or maximized, Windows restores it
			-- to its original size and position. An application should specify this flag when displaying
			-- the window for the first time
		external
			"C MACRO use <shellapi.h>"
		alias
			"SW_SHOWNORMAL"
		end

;note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
