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

	get is 
		require
			not_exists: not exists
		deferred
		ensure
			exists: exists
		end

	release is 
		require
			exists: exists
		deferred
		ensure
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

	cwin_get_window_dc (hwnd: POINTER): POINTER is
			-- SDK GetWindowDC
		external
			"C [macro <wel.h>] (HWND): EIF_POINTER"
		alias
			"GetWindowDC"
		end

	cwin_begin_paint (hwnd, paint_struct: POINTER): POINTER is
			-- SDK BeginPaint
		external
			"C [macro <wel.h>] (HWND, PAINTSTRUCT *): EIF_POINTER"
		alias
			"BeginPaint"
		end

	cwin_end_paint (hwnd, paint_struct: POINTER) is
			-- SDK EndPaint
		external
			"C [macro <wel.h>] (HWND, PAINTSTRUCT *)"
		alias
			"EndPaint"
		end

	cwin_release_dc (hwnd, hdc: POINTER) is
			-- SDK ReleaseDC
		external
			"C [macro <wel.h>] (HWND, HDC)"
		alias
			"ReleaseDC"
		end

end -- class WEL_DISPLAY_DC

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
