indexing
	description: "Window control color message (WM) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_WM_CTLCOLOR_CONSTANTS

feature -- Access

	Wm_ctlcolorstatic: INTEGER is
		external
			"C [macro <winuser.h>]"
		alias
			"WM_CTLCOLORSTATIC"
		end

	Wm_ctlcolorbtn: INTEGER is
		external
			"C [macro <winuser.h>]"
		alias
			"WM_CTLCOLORBTN"
		end

	Wm_ctlcoloredit: INTEGER is
		external
			"C [macro <winuser.h>]"
		alias
			"WM_CTLCOLOREDIT"
		end

	Wm_ctlcolorlistbox: INTEGER is
		external
			"C [macro <winuser.h>]"
		alias
			"WM_CTLCOLORLISTBOX"
		end

	Wm_ctlcolormsgbox: INTEGER is
		external
			"C [macro <winuser.h>]"
		alias
			"WM_CTLCOLORMSGBOX"
		end

	Wm_ctlcolorscrollbar: INTEGER is
		external
			"C [macro <winuser.h>]"
		alias
			"WM_CTLCOLORSCROLLBAR"
		end

end -- class WEL_WM_CTLCOLOR_CONSTANTS

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
