indexing
	description: "General representation of a device context that %
		%can be displayed on the screen."
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

end -- class WEL_DISPLAY_DC


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

