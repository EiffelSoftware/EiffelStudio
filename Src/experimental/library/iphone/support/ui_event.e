note
	description: "Wrapper around UIEvent class."
	date: "$Date$"
	revision: "$Revision$"

class
	UI_EVENT

inherit
	NS_OBJECT

create
	share_from_pointer

feature -- Access

	all_touches: NS_SET [UI_TOUCH]
		require
			exists: exists
		do
			create Result.make_from_pointer (c_touches (item))
		end

feature {NONE} -- Externals

	c_touches (a_event_ptr: POINTER): POINTER
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"return [(UIEvent *) $a_event_ptr allTouches];"
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
