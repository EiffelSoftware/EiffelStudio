note
	description: "[
					Utilities for Eiffel HighDPI wrapper library.
					]"
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SCALING_UTILITY

feature -- Query

	api_loader: DYNAMIC_MODULE
				-- API dynamic loader
		local
			l_platform: PLATFORM
		once
			create l_platform
			check is_window: l_platform.is_windows end
			create {DYNAMIC_MODULE} Result.make (module_name)
		ensure
			not_void: Result /= Void
		end

	module_name: STRING
			-- Module name.
		once
			Result := "Shcore"
		ensure
			not_void: Result /= Void
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
