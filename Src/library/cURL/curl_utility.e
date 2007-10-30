indexing
	description: "[
					Utilities for Eiffel cURL wrapper library.
																		]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CURL_UTILITY

feature -- Query

	module_name: STRING is
			-- Module name.
		local
			l_platform: PLATFORM
		once
			create l_platform
			if l_platform.is_windows then
				Result := "libcurl.dll"
			else
				Result := "libcurl.so"
			end
		ensure
			not_void: Result /= Void
		end

indexing
	library:   "cURL: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2006, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
