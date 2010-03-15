note
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

	api_loader: DYNAMIC_MODULE
			-- API dynamic loader
		local
			l_platform: PLATFORM
		once
			create l_platform
			if l_platform.is_unix or l_platform.is_mac then
				create Result.make_with_version (module_name, "3")
			else
				check is_window: l_platform.is_windows end
				create Result.make (module_name)
			end
		ensure
			not_void: Result /= Void
		end
		
	module_name: STRING
			-- Module name.
		once
				Result := "libcurl"
		ensure
			not_void: Result /= Void
		end

note
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
