note
	description: "Summary description for {UI_WINDOW}."
	date: "$Date$"
	revision: "$Revision$"

class
	UI_WINDOW

inherit
	UI_VIEW
		redefine
			iphone_class_name
		end

create
	make

create
	share_from_pointer

feature {NONE} -- Initialization

	make (a_rect: CG_RECT)
		do
			allocate_object
			init_with_frame (a_rect)
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

feature {NONE} -- Implementation

	iphone_class_name: IMMUTABLE_STRING_8
			-- <Precursor>
		once
			create Result.make_from_string ("UIWindow")
		end

feature {NONE} -- Externals

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
