indexing
	description: "Track Bar (common control) Message (TBM) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TBM_CONSTANTS

feature -- Access

	Tbm_getpos: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TBM_GETPOS"
		end

	Tbm_getrangemin: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TBM_GETRANGEMIN"
		END

	Tbm_getrangemax: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TBM_GETRANGEMAX"
		end

	Tbm_gettic: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TBM_GETTIC"
		end

	Tbm_settic: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TBM_SETTIC"
		end

	Tbm_setpos: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TBM_SETPOS"
		end

	Tbm_setrange: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TBM_SETRANGE"
		end

	Tbm_setrangemin: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TBM_SETRANGEMIN"
		end

	Tbm_setrangemax: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TBM_SETRANGEMAX"
		end

	Tbm_cleartics: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TBM_CLEARTICS"
		end

	Tbm_setsel: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TBM_SETSEL"
		end

	Tbm_setselstart: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TBM_SETSELSTART"
		end

	Tbm_setselend: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TBM_SETSELEND"
		end

	Tbm_getptics: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TBM_GETPTICS"
		end

	Tbm_getticpos: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TBM_GETTICPOS"
		end

	Tbm_getnumtics: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TBM_GETNUMTICS"
		end

	Tbm_getselstart: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TBM_GETSELSTART"
		end

	Tbm_getselend: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TBM_GETSELEND"
		end

	Tbm_clearsel: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TBM_CLEARSEL"
		end

end -- class WEL_TBM_CONSTANTS

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
