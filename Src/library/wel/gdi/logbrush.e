indexing
	description: "Defines the style, color and pattern of %
		%a physical brush."
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
		require
			color_not_void: a_color /= Void
			color_exists: a_color.exists
		do
			structure_make
			set_style (a_style)
			set_color (a_color)
			set_hatch (a_hatch)
		ensure
			style_set: style = a_style
			color_set: color.item = a_color.item
			hatch_set: hatch = a_hatch
		end

	make_by_brush (brush: WEL_BRUSH) is
		require
			brush_not_void: brush /= Void
			brush_exists: brush.exists
		do
			structure_make
			cwin_get_object (brush.item, structure_size, item)
		end

feature -- Access

	style: INTEGER is
			-- Brush style
		require
			exists: exists
		do
			Result := cwel_logbrush_get_style (item)
		end

	color: WEL_COLOR_REF is
			-- Brush color
		require
			exists: exists
		do
			!! Result.make_by_pointer (cwel_logbrush_get_color (item))
		ensure
			result_not_void: Result /= Void
			result_exists: Result.exists
		end

	hatch: INTEGER is
			-- Brush hatch
		require
			exists: exists
		do
			Result := cwel_logbrush_get_hatch (item)
		end

feature -- Element changes

	set_style (a_style: INTEGER) is
			-- Set `style' with `a_style'
		require
			exists: exists
		do
			cwel_logbrush_set_style (item, a_style)
		ensure
			style_set: style = a_style
		end

	set_color (a_color: WEL_COLOR_REF) is
			-- Set `color' with `a_color'
		require
			exists: exists
			a_color_not_void: a_color /= Void
			a_color_exists: a_color.exists
		do
			cwel_logbrush_set_color (item, a_color.item)
		ensure
			color_set: color.item = a_color.item
		end

	set_hatch (a_hatch: INTEGER) is
			-- Set `hatch' with `a_hatch'
		require
			exists: exists
		do
			cwel_logbrush_set_hatch (item, a_hatch)
		ensure
			hatch_set: hatch = a_hatch
		end

feature {WEL_STRUCTURE} -- Measurement

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
			"C [macro <logbrush.h>]"
		end

	cwel_logbrush_get_color (ptr: POINTER): POINTER is
		external
			"C [macro <logbrush.h>]"
		end

	cwel_logbrush_get_hatch (ptr: POINTER): INTEGER is
		external
			"C [macro <logbrush.h>]"
		end

	cwel_logbrush_set_style (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <logbrush.h>]"
		end

	cwel_logbrush_set_color (ptr: POINTER; value: POINTER) is
		external
			"C [macro <logbrush.h>]"
		end

	cwel_logbrush_set_hatch (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <logbrush.h>]"
		end

	cwin_get_object (hgdi_object: POINTER; buffer_size: INTEGER;
			object: POINTER) is
		external
			"C [macro <wel.h>] (HGDIOBJ, int, LPVOID)"
		alias
			"GetObject"
		end

invariant
	color_not_void: exists implies color /= Void
	color_exists: exists implies color.exists

end -- class WEL_LOG_BRUSH

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
