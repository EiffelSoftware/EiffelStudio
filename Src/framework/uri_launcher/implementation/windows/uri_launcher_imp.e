indexing
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

-- inherit {NONE}
	SHARED_API_MARSHALLER
		export
			{NONE} all
		end

feature -- Basic operations

	launch (a_uri: !STRING_GENERAL): BOOLEAN
			-- <Precursor>
		local
			l_cleaner: !API_MARSHALLED_DATA_AUTO_CLEANER
			l_op: POINTER
			l_uri: POINTER
			l_null: POINTER
		do
			check is_windows: {PLATFORM}.is_windows end

				-- Marshal c-data
			create l_cleaner.make (marshaller)
			l_op := marshaller.string_to_tstring ("open")
			l_uri := marshaller.string_to_tstring (a_uri)
			l_cleaner.auto_free (l_op)
			l_cleaner.auto_free (l_uri)

			Result := cwin_shell_execute (l_null, l_null, l_uri, l_null, l_null, cwin_sw_shownormal) = 0

			l_cleaner.clean
		rescue
			l_cleaner.clean
		end

feature {NONE} -- Externals

	cwin_shell_execute (a_hwnd: POINTER; a_operation: POINTER; a_file: POINTER; a_params: POINTER; a_directory: POINTER; a_show_cmd: INTEGER): INTEGER
			-- Performs an operation on a specified file.
		external
			"C signature (HWND, LPCTSTR, LPCTSTR, LPCTSTR, LPCTSTR, INT): HINSTANCE use <shellapi.h>"
		alias
			"ShellExecute"
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

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
