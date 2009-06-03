note
	description: "Way to access the shared UI_APPLICATION object."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_UI_APPLICATION

feature -- Access

	application: UI_APPLICATION
			-- Shared application
		require
			has_application: has_application
		once
			create Result.share_from_pointer (c_application)
		end

feature -- Status report

	has_application: BOOLEAN
		do
			Result := c_application /= default_pointer
		end

feature {NONE} -- Implementation

	c_application: POINTER
			-- Access to UIApplication shared object.
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"return [UIApplication sharedApplication];"
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
