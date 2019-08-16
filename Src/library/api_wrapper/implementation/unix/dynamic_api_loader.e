note
	description: "The Unix implementation of the dynamic API loader {DYNAMIC_API_I}."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DYNAMIC_API_LOADER

inherit
	DYNAMIC_API_LOADER_I

feature -- Status report

	is_dynamic_library_supported: BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

feature -- Query

	api_pointer (a_hnd: POINTER; a_api_name: READABLE_STRING_8): POINTER
			-- <Precursor>
		local
			l_name: C_STRING
		do
			create l_name.make (a_api_name)
			Result := c_dlsym (a_hnd, l_name.item)
		end

feature -- Basic operations

	load_library (a_name: READABLE_STRING_GENERAL; a_version: detachable READABLE_STRING_GENERAL): POINTER
			-- <Precursor>
		local
			l_fn: PATH
		do
			create l_fn.make_from_string (a_name)
			if {PLATFORM}.is_mac then
				Result := load_library_from_path
					((if attached a_version then
						l_fn.appended_with_extension (a_version)
					else
						l_fn
					end).appended_with_extension (once "dylib").utf_8_name)
			end
			if Result = default_pointer then
					-- Not a Mac or dylib not found, attempt so
				l_fn := l_fn.appended_with_extension (once "so")
				Result := load_library_from_path
					((if attached a_version then
						l_fn.appended_with_extension (a_version)
					else
						l_fn
					end).utf_8_name)
			end
		end

	load_library_from_path (a_path: READABLE_STRING_GENERAL): POINTER
			-- <Precursor>
		local
			l_path: C_STRING
		do
			create l_path.make (a_path)
				-- Second parameter specifies to bind symbols only when necessary, instead of doing it all on load.
				-- Note: Using flag RTLD_GLOBAL, instead of RTLD_LOCAL may resolve potential issues with symbol name
				--       conflicts but it is not used because it may cause problems for multi-threaded applications,
				--       but if it creates a issue with conflicts then this may have to be used.
			Result := c_dlopen (l_path.item, RTLD_LAZY | RTLD_GLOBAL)
		end

	unload_library (a_hnd: POINTER)
			-- <Precursor>
		local
			l_result: BOOLEAN
		do
			l_result := c_dlclose (a_hnd) = 0
			check
				library_freed: l_result
			end
		end

feature {NONE} -- Externals

	c_dlopen (a_file_name: POINTER; a_flags: INTEGER): POINTER
			-- The function dlopen() loads the dynamic library file named by the null-terminated string
			-- filename and returns an opaque "handle" for the dynamic library. If filename is NULL, then
			-- the returned handle is for the main program. If filename contains a slash ("/"), then it is
			-- interpreted as a (relative or absolute) pathname. Otherwise, the dynamic linker searches for
			-- the library as follows (see ld.so(8) for further details):
		require
			not_a_file_name_is_null: a_file_name /= default_pointer
		external
			"C inline use <dlfcn.h>"
		alias
			"return (EIF_POINTER)dlopen((const char*)$a_file_name, (int)$a_flags);"
		end

	c_dlclose (a_handle: POINTER): INTEGER
			-- The function dlsym() takes a "handle" of a dynamic library returned by dlopen() and the
			-- null-terminated symbol name, returning the address where that symbol is loaded into memory.
			-- If the symbol is not found, in the specified library or any of the libraries that were
			-- automatically loaded by dlopen() when that library was loaded, dlsym() returns NULL.
		require
			not_a_handle_is_null: a_handle /= default_pointer
		external
			"C inline use <dlfcn.h>"
		alias
			"return (EIF_INTEGER)dlclose((void *)$a_handle);"
		end

	c_dlsym (a_handle: POINTER; a_symbol: POINTER): POINTER
			-- The function dlsym() takes a "handle" of a dynamic library returned by dlopen() and the null-
			-- terminated symbol name, returning the address where that symbol is loaded into memory.
		require
			not_a_handle_is_null: a_handle /= default_pointer
			not_a_symbol_is_null: a_symbol /= default_pointer
		external
			"C inline use <dlfcn.h>"
		alias
			"return dlsym((void *)$a_handle, (const char *)$a_symbol);"
		end

feature {NONE} -- External: Flags

	RTLD_LAZY: INTEGER
			-- Perform lazy binding. Only resolve symbols as the code that references them is executed. If
			-- the symbol is never referenced, then it is never resolved.
		external
			"C macro use <dlfcn.h>"
		alias
			"RTLD_LAZY"
		end

	RTLD_GLOBAL: INTEGER
			-- The symbols defined by this library will be made available for symbol resolution of
			-- subsequently loaded libraries.
		external
			"C macro use <dlfcn.h>"
		alias
			"RTLD_GLOBAL"
		end

;note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
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

