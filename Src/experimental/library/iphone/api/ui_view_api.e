note
	description: "Containers for all externals of {UI_VIEW_API}."
	date: "$Date$"
	revision: "$Revision$"

class
	UI_VIEW_API

feature -- Initialization

	init_with_frame (a_win_ptr, a_rect_ptr: POINTER)
		require
--			a_win_ptr_not_null: a_win_ptr /= default_pointer
--			a_rect_ptr_not_null: a_rect_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"[(UIView *) $a_win_ptr initWithFrame:*(CGRect *) $a_rect_ptr];"
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
