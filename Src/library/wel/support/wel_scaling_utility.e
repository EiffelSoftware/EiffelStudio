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
		once
			Result := c_load_shcore_dll
		end

feature -- Status

	is_scaling_installed: BOOLEAN
			-- Can "Shcore.dll" be found on user's machine?
		do
			Result := scaling_handle /= default_pointer
		end

feature {NONE} -- Externals

	c_load_shcore_dll: POINTER
			-- Try to load Shcore.dll, if fount return 1.
		external
			"C inline use <shellscalingapi.h>"
		alias
			"return (EIF_POINTER) LoadLibrary (L%"Shcore.dll%");"
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
