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

	Hwnd_broadcast: POINTER is
		external
			"C [macro <windows.h>] : EIF_POINTER"
		alias
			"HWND_BROADCAST"
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
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

