indexing
	description: "Defines the style, width and color of a pen."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_LOG_PEN

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		end

	WEL_PS_CONSTANTS
		export
			{NONE} all
			{ANY} valid_pen_style_constant
		end

creation
	make,
	make_by_pen

feature {NONE} -- Initialization

	make (a_style, a_width: INTEGER; a_color: WEL_COLOR_REF) is
			-- Make a log pen using `a_style', `a_width' and
			-- `a_color'.
			-- See class WEL_PS_CONSTANTS for `a_style' values.
		require
			valid_pen_style_constant: valid_pen_style_constant (a_style)
			positive_width: a_width >= 0
			color_not_void: a_color /= Void
		do
			structure_make
			set_style (a_style)
			set_width (a_width)
			set_color (a_color)
		ensure
			set_style: style = a_style
			set_width: width = a_width
			set_color: color.item = a_color.item
		end

	make_by_pen (pen: WEL_PEN) is
			-- Make a log pen using the information of `pen'.
		require
			pen_not_void: pen /= Void
			pen_exists: pen.exists
		do
			structure_make
			cwin_get_object (pen.item, structure_size, item)
		end

feature -- Access

	style: INTEGER is
			-- Pen style
		do
			Result := cwel_logpen_get_style (item)
		ensure
			valid_result: valid_pen_style_constant (Result)
		end

	width: INTEGER is
			-- Pen width
		do
			Result := cwel_logpen_get_width (item)
		ensure
			positive_result: Result >= 0
		end

	color: WEL_COLOR_REF is
			-- Pen color
		do
			create Result.make_by_color (cwel_logpen_get_color (item))
		ensure
			result_not_void: Result /= Void
		end

feature -- Element change

	set_style (a_style: INTEGER) is
			-- Set `style' with `a_style'
		require
			valid_pen_style_constant: valid_pen_style_constant (a_style)
		do
			cwel_logpen_set_style (item, a_style)
		ensure
			set_style: style = a_style
		end

	set_width (a_width: INTEGER) is
			-- Set `width' with `a_width'
		require
			positive_width: a_width >= 0
		do
			cwel_logpen_set_width (item, a_width)
			cwel_logpen_set_y (item, 0)
		ensure
			set_width: width = a_width
		end

	set_color (a_color: WEL_COLOR_REF) is
			-- Set `color' with `a_color'
		require
			a_color_not_void: a_color /= Void
		do
			cwel_logpen_set_color (item, a_color.item)
		ensure
			set_color: color.item = a_color.item
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_logpen
		end

feature {NONE} -- Externals

	c_size_of_logpen: INTEGER is
		external
			"C [macro <logpen.h>]"
		alias
			"sizeof (LOGPEN)"
		end

	cwel_logpen_get_style (ptr: POINTER): INTEGER is
		external
			"C [macro <logpen.h>]"
		end

	cwel_logpen_get_width (ptr: POINTER): INTEGER is
		external
			"C [macro <logpen.h>]"
		end

	cwel_logpen_get_color (ptr: POINTER): INTEGER is
		external
			"C [macro <logpen.h>]"
		end

	cwel_logpen_set_style (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <logpen.h>]"
		end

	cwel_logpen_set_width (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <logpen.h>]"
		end

	cwel_logpen_set_color (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <logpen.h>]"
		end

	cwel_logpen_set_y (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <logpen.h>]"
		end

	cwin_get_object (hgdi_object: POINTER; buffer_size: INTEGER;
			object: POINTER) is
		external
			"C [macro <windows.h>] (HGDIOBJ, int, LPVOID)"
		alias
			"GetObject"
		end

invariant
	color_not_void: color /= Void
	positive_width: width >= 0

end -- class WEL_LOG_PEN


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

