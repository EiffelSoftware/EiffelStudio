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
			"C [macro <wel.h>]"
		alias
			"SWP_NOSIZE"
		end

	Swp_nomove: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SWP_NOMOVE"
		end

	Swp_nozorder: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SWP_NOZORDER"
		end

	Swp_noredraw: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SWP_NOREDRAW"
		end

	Swp_noactivate: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SWP_NOACTIVATE"
		end

	Swp_framechanged: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SWP_FRAMECHANGED"
		end

	Swp_showwindow: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SWP_SHOWWINDOW"
		end

	Swp_hidewindow: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SWP_HIDEWINDOW"
		end

	Swp_nocopybits: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SWP_NOCOPYBITS"
		end

	Swp_noownerzorder: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SWP_NOOWNERZORDER"
		end

	Swp_drawframe: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SWP_DRAWFRAME"
		end

	Swp_noreposition: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SWP_NOREPOSITION"
		end

end -- class WEL_SWP_CONSTANTS

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
