indexing
	description: "SetWindowPosition (SWP) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SWP_CONSTANTS

feature -- Access

	Swp_nosize: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SWP_NOSIZE"
		end

	Swp_nomove: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SWP_NOMOVE"
		end

	Swp_nozorder: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SWP_NOZORDER"
		end

	Swp_noredraw: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SWP_NOREDRAW"
		end

	Swp_noactivate: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SWP_NOACTIVATE"
		end

	Swp_framechanged: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SWP_FRAMECHANGED"
		end

	Swp_showwindow: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SWP_SHOWWINDOW"
		end

	Swp_hidewindow: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SWP_HIDEWINDOW"
		end

	Swp_nocopybits: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SWP_NOCOPYBITS"
		end

	Swp_noownerzorder: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SWP_NOOWNERZORDER"
		end

	Swp_drawframe: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SWP_DRAWFRAME"
		end

	Swp_noreposition: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SWP_NOREPOSITION"
		end

end -- class WEL_SWP_CONSTANTS

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

