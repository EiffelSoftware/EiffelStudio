indexing
	description: "Defines the style, color and pattern of %
		% a physical brush. Encapsulate the C struct LOGPEN %
		% (a WEL_LOG_BRUSH is NOT a BRUSH, this is a structure.)"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_LOG_BRUSH

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		end

creation
	make,
	make_by_brush

feature {NONE} -- Initialization

	make (a_style: INTEGER; a_color: WEL_COLOR_REF; a_hatch: INTEGER) is
			-- Make a log brush using `a_style', `a_color' and
			-- `a_hatch' type.
			-- See class WEL_BRUSH_STYLE_CONSTANTS for `a_style'
			-- values.
			-- See class WEL_HS_CONSTANTS for `a_hatch' values.
		require
			color_not_void: a_color /= Void
		do
			structure_make
			set_style (a_style)
			set_color (a_color)
			set_hatch (a_hatch)
		ensure
			style_set: style = a_style
			hatch_set: hatch = a_hatch
		end

	make_by_brush (brush: WEL_BRUSH) is
			-- Make a log brush using the information of `brush'.
		require
			brush_not_void: brush /= Void
			brush_exists: brush.exists
		do
			structure_make
			cwin_get_object (brush.item, structure_size, item)
		ensure
			style_set: style = brush.style
			color_set: color.is_equal (brush.color)
			hatch_set: hatch = brush.hatch
		end

feature -- Access

	style: INTEGER is
			-- Brush style
		do
			Result := cwel_logbrush_get_style (item)
		end

	color: WEL_COLOR_REF is
			-- Brush color
		do
			create Result.make_by_color (cwel_logbrush_get_color (item))
		ensure
			result_not_void: Result /= Void
		end

	hatch: INTEGER is
			-- Brush hatch
		do
			Result := cwel_logbrush_get_hatch (item)
		end

feature -- Element change

	set_style (a_style: INTEGER) is
			-- Set `style' with `a_style'
		do
			cwel_logbrush_set_style (item, a_style)
		ensure
			style_set: style = a_style
		end

	set_color (a_color: WEL_COLOR_REF) is
			-- Set `color' with `a_color'
		require
			a_color_not_void: a_color /= Void
		do
			cwel_logbrush_set_color (item, a_color.item)
		end

	set_hatch (a_hatch: INTEGER) is
			-- Set `hatch' with `a_hatch'
		do
			cwel_logbrush_set_hatch (item, a_hatch)
		ensure
			hatch_set: hatch = a_hatch
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_logbrush
		end

feature {NONE} -- Externals

	c_size_of_logbrush: INTEGER is
		external
			"C [macro <logbrush.h>]"
		alias
			"sizeof (LOGBRUSH)"
		end

	cwel_logbrush_get_style (ptr: POINTER): INTEGER is
		external
			"C [macro %"logbrush.h%"]"
		end

	cwel_logbrush_get_color (ptr: POINTER): INTEGER is
		external
			"C [macro %"logbrush.h%"]"
		end

	cwel_logbrush_get_hatch (ptr: POINTER): INTEGER is
		external
			"C [macro %"logbrush.h%"]"
		end

	cwel_logbrush_set_style (ptr: POINTER; value: INTEGER) is
		external
			"C [macro %"logbrush.h%"]"
		end

	cwel_logbrush_set_color (ptr: POINTER; value: INTEGER) is
		external
			"C [macro %"logbrush.h%"]"
		end

	cwel_logbrush_set_hatch (ptr: POINTER; value: INTEGER) is
		external
			"C [macro %"logbrush.h%"]"
		end

	cwin_get_object (hgdi_object: POINTER; buffer_size: INTEGER; object: POINTER) is
		external
			"C [macro <windows.h>] (HGDIOBJ, int, LPVOID)"
		alias
			"GetObject"
		end

invariant
	color_not_void: color /= Void

end -- class WEL_LOG_BRUSH


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

