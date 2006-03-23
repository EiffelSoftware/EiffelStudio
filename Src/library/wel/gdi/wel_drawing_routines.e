indexing
	description: "Basic windows routines to draw controls like%
				% owner-draw-buttons."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_DRAWING_ROUTINES

inherit
	WEL_DRAWING_ROUTINES_CONSTANTS
		export
			{NONE} all
		end

	WEL_DIB_COLORS_CONSTANTS
		export
			{NONE} all
		end
		
	WEL_DATA_TYPE
		export
			{NONE} all
		end

	WEL_DT_CONSTANTS

feature -- Basic operations

	draw_edge (dc: WEL_DC; rect: WEL_RECT; type, border: INTEGER) is
			-- Draw a edge corresponding to the given options.
			-- See WEL_DRAWING_ROUTINES_CONSTANTS for `type' and
			-- `border'.
		require
			rect_not_void: rect /= Void
			dc_not_void: dc /= Void
			dc_exists: dc.exists
		do
			cwin_draw_edge (dc.item, rect.item, type, border)
		end

	draw_focus_rect (dc: WEL_DC; rect: WEL_RECT) is
			-- Draw a focus line in the given rect.
		require
			rect_not_void: rect /= Void
			dc_not_void: dc /= Void
			dc_exists: dc.exists
		do
			cwin_draw_focus_rect (dc.item, rect.item)
		end

	draw_insensitive_text (dc: WEL_DC; txt: STRING_GENERAL; x, y: INTEGER) is
			-- Draw the given text with the insensitive
		require
			txt_not_void: txt /= Void
			dc_not_void: dc /= Void
			dc_exists: dc.exists
		local
			wel_string: WEL_STRING
		do
			create wel_string.make (txt)
			cwin_draw_state (dc.item, default_pointer, default_pointer,
					wel_string.item, to_lparam (txt.count), x, y, dc.tabbed_text_width (txt),
					dc.tabbed_text_height (txt), Dst_text + Dss_disabled)
		end

	draw_insensitive_bitmap (dc: WEL_DC; bitmap: WEL_BITMAP; x, y: INTEGER) is
			-- Draw the given bitmap converted to look insensitive
		require
			bitmap_not_void: bitmap /= Void
			bitmap_exists: bitmap.exists
			dc_not_void: dc /= Void
			dc_exists: dc.exists
		do
			cwin_draw_state (dc.item, default_pointer, default_pointer,
					bitmap.item, default_pointer, x, y, 0, 0,
					Dst_bitmap + Dss_disabled)
		end

feature {NONE} -- Externals

	cwin_draw_edge (hdc, rect: POINTER; type, border: INTEGER) is
		external
			"C [macro <windows.h>] (HDC, LPRECT, UINT, UINT)"
		alias
			"DrawEdge"
		end

	cwin_draw_focus_rect (hdc, rect: POINTER) is
		external
			"C [macro <windows.h>] (HDC, CONST RECT *)"
		alias
			"DrawFocusRect"
		end

	cwin_draw_state (hdc, hbrush, callback: POINTER; lparam, wparam: POINTER; x, y, cx, cy, flag: INTEGER) is
			-- The flag is a combination of a type and a state.
		external
			"C [macro <windows.h>] (HDC, HBRUSH, DRAWSTATEPROC, LPARAM, WPARAM, int, int, int, int, UINT)"
		alias
			"DrawState"
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_DRAWING_ROUTINES

