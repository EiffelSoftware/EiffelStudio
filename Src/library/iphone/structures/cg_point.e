note
	description: "Wrapper around CGPoint structure."
	date: "$Date$"
	revision: "$Revision$"

class
	CG_POINT

inherit
	MEMORY_STRUCTURE
		rename
			make as make_empty
		end

create
	make,
	make_empty,
	make_by_pointer

feature {NONE} -- Initialization

	make (a_x, a_y: REAL)
			-- New point at coordinates (`a_x', `a_y').
		do
			make_empty
			set_x (a_x)
			set_y (a_y)
		end

feature -- Access

	x: REAL
			-- X coordinates of Current
		require
			exists: exists
		do
			Result := c_point_x (item)
		end

	y: REAL
			-- Y coordinates of Current
		require
			exists: exists
		do
			Result := c_point_y (item)
		end

feature -- Settings

	set_x (a_x: like x)
			-- Set `x' coordinates of Current with `a_x'.
		require
			exists: exists
		do
			c_point_set_x (item, a_x)
		ensure
			set: x = a_x
		end

	set_y (a_y: like y)
			-- Set `y' coordinates of Current with `a_y'.
		require
			exists: exists
		do
			c_point_set_y (item, a_y)
		ensure
			set: y = a_y
		end


feature -- Measurement

	structure_size: INTEGER
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"return sizeof(CGPoint);"
		end

feature {NONE} -- Externals

	c_point_x (a_ptr: POINTER): REAL
		require
			a_ptr_not_null: a_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"return ((CGPoint *) $a_ptr)->x"
		end

	c_point_y (a_ptr: POINTER): REAL
		require
			a_ptr_not_null: a_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"return ((CGPoint *) $a_ptr)->y"
		end

	c_point_set_x (a_ptr: POINTER; a_x: REAL)
		require
			a_ptr_not_null: a_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"((CGPoint *) $a_ptr)->x = $a_x;"
		end

	c_point_set_y (a_ptr: POINTER; a_y: REAL)
		require
			a_ptr_not_null: a_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"((CGPoint *) $a_ptr)->y = $a_y;"
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
