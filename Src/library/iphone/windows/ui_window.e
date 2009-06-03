note
	description: "Summary description for {UI_WINDOW}."
	date: "$Date$"
	revision: "$Revision$"

class
	UI_WINDOW

inherit
	UI_VIEW

create
	make

feature {NONE} -- Initialization

	make (a_rect: CG_RECT)
		do
			make_from_pointer (c_new_window (a_rect.item))
			c_set_color (item)
		end

feature -- Display

	show
			-- Ensure that Current is visible.
		require
			exists: exists
		do
			c_show (item)
		end

feature -- Element change

	extend (a_label: UI_LABEL)
			-- Add `a_label' as a child of Current.
		require
			exists: exists
			a_label_exists: a_label.exists
		do
			c_add_subview (item, a_label.item)
		end

feature {NONE} -- Externals

	c_new_window (a_rect_ptr: POINTER): POINTER
		require
			a_rect_ptr_not_null: a_rect_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"return [[UIWindow alloc] initWithFrame:*(CGRect *) $a_rect_ptr];"
		end

	c_show (a_win_ptr: POINTER)
		require
			a_win_ptr_not_null: a_win_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"[((UIWindow *) $a_win_ptr) makeKeyAndVisible];"
		end

	c_set_color (a_win_ptr: POINTER)
		require
			a_win_ptr_not_null: a_win_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"((UIWindow *) $a_win_ptr).backgroundColor = [UIColor blueColor];"
		end

	c_add_subview (a_win_ptr, a_view_ptr: POINTER)
		require
			a_win_ptr_not_null: a_win_ptr /= default_pointer
			a_view_ptr_not_null: a_view_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"[((UIWindow *) $a_win_ptr) addSubview:((UIView *) $a_view_ptr)];"
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
