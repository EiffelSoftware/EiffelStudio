indexing
	description: "[
		The GTK implementation of the dynamic API loader {DYNAMIC_API_LOADER}.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	DYNAMIC_API_LOADER_IMP_GTK

inherit
	DYNAMIC_API_LOADER

feature -- Query

	api_pointer (a_hnd: POINTER; a_api_name: ?STRING_GENERAL): POINTER
			-- <Precursor>
		local
			l_name: !EV_GTK_C_STRING
			l_result: BOOLEAN
		do
			create l_name.make (a_api_name)
			l_result := {EV_GTK_EXTERNALS}.g_module_symbol (a_module, l_c_string.item, $Result)
		end

feature -- Basic operations

	load_library (a_name: ?STRING_GENERAL): POINTER
			-- <Precursor>
		local
			l_fn: !FILE_NAME
		do
			create l_fn.make_from_string (a_name.as_string_8)
			if {PLATFORM}.is_mac then
				l_fn.add_extension (once "dylib")
				Result := load_library_from_path (l_fn.string)
			end
			if Result = default_pointer then
					-- Not a Mac or dylib not found, attempt so
				create l_fn.make_from_string (a_name.as_string_8)
				l_fn.add_extension (once "so")
				Result := load_library_from_path (l_fn.string)
			end
		end

	load_library_from_path (a_path: ?STRING_GENERAL): POINTER
			-- <Precursor>
		local
			l_path: !EV_GTK_C_STRING
		do
			create l_path.make (a_path)
			Result := {EV_GTK_EXTERNALS}.g_module_open (a_path.item, 0)
		end
		
	unload_library (a_hnd: POINTER)
			-- <Precursor>
		local
			l_result: BOOLEAN
		do
			l_result := {EV_GTK_EXTERNALS}.g_module_close (a_hnd)
			check library_freed: l_result end
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
