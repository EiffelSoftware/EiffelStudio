indexing
	description: "Button messages (BM) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_BM_CONSTANTS

feature -- Access

	Bm_getcheck: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"BM_GETCHECK"
		end

	Bm_setcheck: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"BM_SETCHECK"
		end

	Bm_getstate: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"BM_GETSTATE"
		end

	Bm_setstate: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"BM_SETSTATE"
		end

	Bm_setstyle: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"BM_SETSTYLE"
		end

end -- class WEL_BM_CONSTANTS

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
