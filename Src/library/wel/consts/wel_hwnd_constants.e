indexing
	description: "HWND constants used in SetWindowPos."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_HWND_CONSTANTS

feature -- Access

	Hwnd_top: POINTER is
		external
			"C [macro %"wel.h%"] : EIF_POINTER"
		alias
			"HWND_TOP"
		end

	Hwnd_bottom: POINTER is
		external
			"C [macro %"wel.h%"] : EIF_POINTER"
		alias
			"HWND_BOTTOM"
		end

	Hwnd_topmost: POINTER is
		external
			"C [macro %"wel.h%"] : EIF_POINTER"
		alias
			"HWND_TOPMOST"
		end

	Hwnd_notopmost: POINTER is
		external
			"C [macro %"wel.h%"] : EIF_POINTER"
		alias
			"HWND_NOTOPMOST"
		end

feature -- Status report

	valid_hwnd_constant (c: POINTER): BOOLEAN is
			-- Is `c' a valid hwnd constant?
		do
			Result := c = Hwnd_top or else
				c = Hwnd_bottom or else
				c = Hwnd_topmost or else
				c = Hwnd_notopmost
		end

end -- class WEL_HWND_CONSTANTS


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

