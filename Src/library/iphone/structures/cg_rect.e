note
	description: "Wrapper around CGRect structure."
	date: "$Date$"
	revision: "$Revision$"

class
	CG_RECT

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

	make (a_x, a_y, a_width, a_height: REAL)
			-- New rectangle at coordinates (`a_x', `a_y') with dimension (`a_width', `a_height').
		do
			make_empty
			set_x (a_x)
			set_y (a_y)
			set_width (a_width)
			set_height (a_height)
		end

feature -- Access

	x: REAL
			-- X coordinates of Current
		require
			exists: exists
		do
			Result := c_rect_x (item)
		end

	y: REAL
			-- Y coordinates of Current
		require
			exists: exists
		do
			Result := c_rect_y (item)
		end

	width: REAL
			-- Width of Current
		require
			exists: exists
		do
			Result := c_rect_width (item)
		end

	height: REAL
			-- Height of Current
		require
			exists: exists
		do
			Result := c_rect_height (item)
		end

	null: like Current
			-- Predefined null rectangle which is the rectangle returned when, for example,
			-- you intersect two disjoint rectangles.
			-- Note that the null rectangle is not the same as the zero rectangle.
		do
			create Result.make_empty
			Result.item.memory_copy (c_rect_null, structure_size)
		end

feature -- Settings

	set_x (a_x: like x)
			-- Set `x' coordinates of Current with `a_x'.
		require
			exists: exists
		do
			c_rect_set_x (item, a_x)
		ensure
			set: x = a_x
		end

	set_y (a_y: like y)
			-- Set `y' coordinates of Current with `a_y'.
		require
			exists: exists
		do
			c_rect_set_y (item, a_y)
		ensure
			set: y = a_y
		end

	set_width (a_width: like width)
			-- Set `width' of Current with `a_width'.
		require
			exists: exists
		do
			c_rect_set_width (item, a_width)
		ensure
			set: width = a_width
		end

	set_height (a_height: like height)
			-- Set `height' of Current with `a_height'.
		require
			exists: exists
		do
			c_rect_set_height (item, a_height)
		ensure
			set: height = a_height
		end

feature -- Measurement

	structure_size: INTEGER
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"return sizeof(CGRect);"
		end

feature {NONE} -- Externals

	c_rect_null: POINTER
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"return (EIF_POINTER) &CGRectNull;"
		end

	c_rect_x (a_ptr: POINTER): REAL
		require
			a_ptr_not_null: a_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"return ((CGRect *) $a_ptr)->origin.x"
		end

	c_rect_y (a_ptr: POINTER): REAL
		require
			a_ptr_not_null: a_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"return ((CGRect *) $a_ptr)->origin.y"
		end

	c_rect_width (a_ptr: POINTER): REAL
		require
			a_ptr_not_null: a_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"return ((CGRect *) $a_ptr)->size.width"
		end

	c_rect_height (a_ptr: POINTER): REAL
		require
			a_ptr_not_null: a_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"return ((CGRect *) $a_ptr)->size.width"
		end

	c_rect_set_x (a_ptr: POINTER; a_x: REAL)
		require
			a_ptr_not_null: a_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"((CGRect *) $a_ptr)->origin.x = $a_x;"
		end

	c_rect_set_y (a_ptr: POINTER; a_y: REAL)
		require
			a_ptr_not_null: a_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"((CGRect *) $a_ptr)->origin.y = $a_y;"
		end

	c_rect_set_width (a_ptr: POINTER; a_width: REAL)
		require
			a_ptr_not_null: a_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"((CGRect *) $a_ptr)->size.width = $a_width;"
		end

	c_rect_set_height (a_ptr: POINTER; a_height: REAL)
		require
			a_ptr_not_null: a_ptr /= default_pointer
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"((CGRect *) $a_ptr)->size.height = $a_height;"
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
