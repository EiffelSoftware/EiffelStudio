indexing
	description: "HWND constants used in SetWindowPos."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_HWND_CONSTANTS

feature -- Access

	Hwnd_top: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"HWND_TOP"
		end

	Hwnd_bottom: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"HWND_BOTTOM"
		end

	Hwnd_topmost: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"HWND_TOPMOST"
		end

	Hwnd_notopmost: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"HWND_NOTOPMOST"
		end

feature -- Status report

	valid_hwnd_constant (c: INTEGER): BOOLEAN is
			-- Is `c' a valid hwnd constant?
		do
			Result := c = Hwnd_top or else
				c = Hwnd_bottom or else
				c = Hwnd_topmost or else
				c = Hwnd_notopmost
		end

end -- class WEL_HWND_CONSTANTS

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
