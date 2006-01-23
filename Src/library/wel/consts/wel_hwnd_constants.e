indexing
	description: "HWND constants used in SetWindowPos."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_HWND_CONSTANTS

feature -- Access

	frozen Hwnd_top: POINTER is
		external
			"C [macro %"wel.h%"] : EIF_POINTER"
		alias
			"HWND_TOP"
		end

	frozen Hwnd_bottom: POINTER is
		external
			"C [macro %"wel.h%"] : EIF_POINTER"
		alias
			"HWND_BOTTOM"
		end

	frozen Hwnd_topmost: POINTER is
		external
			"C [macro %"wel.h%"] : EIF_POINTER"
		alias
			"HWND_TOPMOST"
		end

	frozen Hwnd_notopmost: POINTER is
		external
			"C [macro %"wel.h%"] : EIF_POINTER"
		alias
			"HWND_NOTOPMOST"
		end

	frozen Hwnd_broadcast: POINTER is
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




end -- class WEL_HWND_CONSTANTS

