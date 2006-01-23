indexing
	description: "General representation of a device context that %
		%can be displayed on the screen."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEL_DISPLAY_DC

inherit
	WEL_DC

feature -- Basic operations

	quick_release is 
			-- Release the device context without unselecting
			-- selected item. To Avoid memory leak, the caller
			-- must be certain that everything is already unselected.
		require
			exists: exists
			no_selected_pen: not pen_selected
			no_selected_brush: not brush_selected
			no_selected_bitmap: not bitmap_selected
			no_selected_font: not font_selected
		deferred
		ensure then
			not_exists: not exists
		end

feature {NONE} -- Externals

	cwin_get_dc (hwnd: POINTER): POINTER is
			-- SDK GetDC
		external
			"C [macro <wel.h>] (HWND): EIF_POINTER"
		alias
			"GetDC"
		end

	cwin_release_dc (hwnd, hdc: POINTER) is
			-- SDK ReleaseDC
		external
			"C [macro <wel.h>] (HWND, HDC)"
		alias
			"ReleaseDC"
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




end -- class WEL_DISPLAY_DC

