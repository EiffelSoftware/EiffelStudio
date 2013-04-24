note
	description: "Wrapper around UIAcceleration class."
	date: "$Date$"
	revision: "$Revision$"

class
	UI_ACCELERATION

inherit
	NS_OBJECT

create
	share_from_pointer

feature -- Access

	x: REAL_64
		require
			exists: exists
		do
			Result := c_x (item)
		end

	y: REAL_64
		require
			exists: exists
		do
			Result := c_y (item)
		end

	z: REAL_64
		require
			exists: exists
		do
			Result := c_z (item)
		end

feature {NONE} -- Externals

	c_x (a_item_ptr: POINTER): REAL_64
		require
			a_item_ptr_not_null: a_item_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"return ((UIAcceleration *) $a_item_ptr).x;"
		end

	c_y (a_item_ptr: POINTER): REAL_64
		require
			a_item_ptr_not_null: a_item_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"return ((UIAcceleration *) $a_item_ptr).y;"
		end

	c_z (a_item_ptr: POINTER): REAL_64
		require
			a_item_ptr_not_null: a_item_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"return ((UIAcceleration *) $a_item_ptr).z;"
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
