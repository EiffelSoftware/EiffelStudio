note
	description: "Summary description for {UI_SCREEN}."
	date: "$Date$"
	revision: "$Revision$"

class
	UI_SCREEN

inherit
	NS_OBJECT

create
	make

feature {NONE} -- Initialization

	make
		local
			l_ptr: POINTER
		do
			l_ptr := c_screen
			if l_ptr /= default_pointer then
				share_from_pointer (l_ptr)
			end
		end

feature -- Access

	bounds: CG_RECT
		require
			exists: exists
		do
			create Result.make_empty
			c_bounds (item, Result.item)
		end

feature {NONE} -- Initialization

	c_screen: POINTER
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"return [UIScreen mainScreen];"
		end

	c_bounds (a_screen_ptr, a_rect_ptr: POINTER)
		require
			a_screen_ptr_not_null: a_screen_ptr /= default_pointer
			a_rect_ptr_not_null: a_rect_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"[
				CGRect l_bounds = [(UIScreen *)$a_screen_ptr bounds];
				memcpy ($a_rect_ptr, &l_bounds, sizeof(CGRect));
			]"
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
