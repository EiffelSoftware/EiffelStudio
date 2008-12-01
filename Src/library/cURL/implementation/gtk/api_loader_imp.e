indexing
	description: "[
					Interactive with native system APIs for dynamic loading.
					GTK verson.
																					]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	API_LOADER_IMP

feature -- Command

	load_module (a_name: STRING): POINTER is
			-- Load module with `a_name'.
			-- `a_name' is LPCTSTR, we should use WEL_STRING here.
		require
			exists: a_name /= Void
		local
			l_c_string: EV_GTK_C_STRING
		do
			l_c_string := a_name
			Result := {EV_GTK_EXTERNALS}.g_module_open (l_c_string.item, 0)
		end

	loal_api (a_module: POINTER; a_name: STRING): POINTER is
			-- Load api which name is `a_name' in `a_module'
		require
			exists: a_module /= default_pointer
			exists: a_name /= Void
		local
			l_c_string: EV_GTK_C_STRING
			l_success: BOOLEAN
			l_result: POINTER
		do
			if a_module /= default_pointer then
				l_c_string := a_name
				l_success := {EV_GTK_EXTERNALS}.g_module_symbol (a_module, l_c_string.item, $l_result)
				if l_success then
					Result := l_result
				end
			end
		end

indexing
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
