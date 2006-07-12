indexing
	description: "Structure containing style and position information for a composition window."
	date: "04/11/2002 11:35"
	revision: "1.0"

class
	WEL_COMPOSITION_FORM

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		end

create
	make

feature -- Initialization

	make is
			-- Create structure with 'pt' and 'rt' and
			-- default positioning style
		do
			structure_make
			create point.make_by_pointer (c_point_address (item))
			create rect.make_by_pointer (c_rect_address (item))
			set_style ({WEL_IME_CONSTANTS}.Cfs_default)
		end

feature -- Access

	point: WEL_POINT
			-- WEL_POINT structure containing the coordinates of the upper-left corner
			-- of the composition window.

	rect: WEL_RECT
			-- WEL_RECT structure containing the coordinates of the upper-left and lower-right
			-- corners of the composition window.

	style: INTEGER is
			-- Position style, can be one of the values from WEL_IME_CONSTANTS
		do
			Result := c_style (item)
		end

feature -- Status Setting

	set_style (sty: INTEGER) is
			-- Set style with 'sty'
		do
			c_set_style (item, sty)
		ensure
			style_set: style = sty
		end

	set_point (a_point: WEL_POINT) is
			-- Set `a_point' tp `point'.
		require
			a_point_not_void: a_point /= Void
			a_point_exists: a_point.exists
		do
			point.copy (a_point)
			set_style ({WEL_IME_CONSTANTS}.cfs_point)
		ensure
			point_set: point.is_equal (a_point)
		end

	set_force_point (a_point: WEL_POINT) is
			-- Set `a_point' tp `point'.
			-- Override IME settings.
		require
			a_point_not_void: a_point /= Void
			a_point_exists: a_point.exists
		do
			point.copy (a_point)
			set_style ({WEL_IME_CONSTANTS}.cfs_force_position)
		ensure
			point_set: point.is_equal (a_point)
		end

	set_rect (a_rect: WEL_RECT) is
			-- Set `rect' with `a_rect'.
		require
			a_rect_not_void: a_rect /= Void
			a_rect_exists: a_rect.exists
		do
			rect.copy (a_rect)
			set_style ({WEL_IME_CONSTANTS}.cfs_rect)
		ensure
			rect_set: rect.is_equal (a_rect)
		end

feature -- Measurment

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_compform
		end

feature -- Externals

	c_size_of_compform: INTEGER is
		external
			"C macro use <windows.h>"
		alias
			"sizeof (COMPOSITIONFORM)"
		end

	c_point_address (a_ptr: POINTER): POINTER is
		external
			"C inline use <windows.h>"
		alias
			"&(((COMPOSITIONFORM *) $a_ptr)->ptCurrentPos)"
		end

	c_rect_address (a_ptr: POINTER): POINTER is
		external
			"C inline use <windows.h>"
		alias
			"&(((COMPOSITIONFORM *) $a_ptr)->rcArea)"
		end

	c_style (a_ptr: POINTER): INTEGER is
		external
			"C inline use <windows.h>"
		alias
			"((COMPOSITIONFORM *) $a_ptr)->dwStyle"
		end

	c_set_style (a_ptr: POINTER; a_value: INTEGER) is
		external
			"C inline use <windows.h>"
		alias
			"((COMPOSITIONFORM *) $a_ptr)->dwStyle = $a_value"
		end

end -- class WEL_COMPOSITION_FORM
