note
	description: "[
					Utilities for Eiffel HighDPI wrapper library.
					]"
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SCALING_UTILITY


feature -- Command

	scaling_handle: POINTER
			-- Handle for `Shcore.dll' if present.
		do
			Result := c_load_shcore_dll
		ensure
			is_class: class
		end

feature -- Status

	is_scaling_installed: BOOLEAN
			-- Can "Shcore.dll" be found on user's machine?
		do
			Result := scaling_handle /= default_pointer
		ensure
			is_class: class
		end

feature -- Destroy

	free_module
			-- Free scaling module.
		require
			scaling_installed: is_scaling_installed
		local
			l_res: BOOLEAN
		do
			l_res := c_free_module (scaling_handle)
			check shcore_dll_free: l_res = True end
		ensure
			is_class: class
		end

feature {NONE} -- Externals

	c_free_module (a_module: POINTER): BOOLEAN
			-- Free module which instance is `a_module'
		external
			"C inline use <windows.h>"
		alias
			"return (BOOL) FreeLibrary ((HMODULE) $a_module);"
		ensure
			is_class: class
		end

	c_load_shcore_dll: POINTER
			-- Try to load Shcore.dll, if fount return 1.
		external
			"C inline use <windows.h>"
		alias
			"return (EIF_POINTER) LoadLibrary (L%"Shcore.dll%");"
		ensure
			is_class: class
		end

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
