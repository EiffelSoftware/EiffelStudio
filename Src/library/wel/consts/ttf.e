indexing
	description: "Tool Tip Flag (TTF) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TTF_CONSTANTS

feature -- Access

	Ttf_idishwnd: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TTF_IDISHWND"
		end

	Ttf_centertip: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TTF_CENTERTIP"
		end

	Ttf_rtlreading: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TTF_RTLREADING"
		end

	Ttf_subclass: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TTF_SUBCLASS"
		end

end -- class WEL_TTF_CONSTANTS

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
