indexing
	description: "Object brush which can be selected into a DC."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_BRUSH

inherit
	WEL_GDI_ANY

creation
	make_by_sys_color,
	make_solid,
	make_hatch,
	make_by_pattern,
	make_indirect,
	make_by_pointer

feature {NONE} -- Initialization

	make_by_sys_color (sys_color: INTEGER) is
			-- Make a brush using the system color `sys_color'.
			-- See class WEL_COLOR_CONSTANTS for `sys_color' value.
			-- Use only this creation routine for a WNDCLASS brush.
		do
			item := cwel_integer_to_pointer (sys_color)
			shared := True
		ensure
			exist: exists
			shared: shared
		end

	make_solid (a_color: WEL_COLOR_REF) is
			-- Make a brush that has the solid `a_color'
		require
			a_color_not_void: a_color /= Void
		do
			item := cwin_create_solid_brush (a_color.item)
		ensure
			exist: exists
			color_set: color.item = a_color.item
		end

	make_hatch (a_hatch: INTEGER; a_color: WEL_COLOR_REF) is
			-- Make a brush that has the
			-- `hatch_style' pattern and `a_color'
			-- See class WEL_HS_CONSTANTS for `a_hatch'
		require
			a_color_not_void: a_color /= Void
		do
			item := cwin_create_hatch_brush (a_hatch, a_color.item)
		ensure
			exist: exists
			hatch_set: hatch = a_hatch
			color_set: color.item = a_color.item
		end

	make_by_pattern (bitmap: WEL_BITMAP) is
			-- Make a brush with the specified `bitmap' pattern.
		require
			bitmap_not_void: bitmap /= Void
			bitmap_exists: bitmap.exists
		do
			item := cwin_create_pattern_brush (bitmap.item)
		ensure
			exist: exists
		end

	make_indirect (a_log_brush: WEL_LOG_BRUSH) is
			-- Make a brush using `a_log_brush'
		require
			a_log_brush_not_void: a_log_brush /= Void
		do
			item := cwin_create_brush_indirect (a_log_brush.item)
		ensure
			exist: exists
		end

feature -- Access

	style: INTEGER is
			-- Brush style
		require
			exists: exists
		do
			Result := log_brush.style
		end

	color: WEL_COLOR_REF is
			-- Brush color
		require
			exists: exists
		do
			Result := log_brush.color
		ensure
			result_not_void: Result /= Void
		end

	hatch: INTEGER is
			-- Brush hatch
		require
			exists: exists
		do
			Result := log_brush.hatch
		end

	log_brush: WEL_LOG_BRUSH is
			-- Create a log brush structure for `Current'
		require
			exists: exists
		do
			!! Result.make_by_brush (Current)
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Externals

	cwin_create_solid_brush (a_color: POINTER): POINTER is
			-- SDK CreateSolidBrush
		external
			"C [macro <wel.h>] (COLORREF): EIF_POINTER"
		alias
			"CreateSolidBrush"
		end

	cwin_create_hatch_brush (hatch_style: INTEGER;
			a_color: POINTER): POINTER is
			-- SDK CreateHatchBrush
		external
			"C [macro <wel.h>] (int, COLORREF): EIF_POINTER"
		alias
			"CreateHatchBrush"
		end

	cwin_create_brush_indirect (a_log_brush: POINTER): POINTER is
			-- SDK CreateBrushIndirect
		external
			"C [macro <wel.h>] (LOGBRUSH *): EIF_POINTER"
		alias
			"CreateBrushIndirect"
		end

	cwin_create_pattern_brush (a_bitmap: POINTER): POINTER is
			-- SDK CreatePatternBrush
		external
			"C [macro <wel.h>] (HBITMAP): EIF_POINTER"
		alias
			"CreatePatternBrush"
		end

end -- class WEL_BRUSH

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
