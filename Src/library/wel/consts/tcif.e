indexing
	description: "Tab control item flag (TCIF) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TCIF_CONSTANTS

feature -- Access

	Tcif_text: INTEGER is
			-- The pszText member is valid.
		external
			"C [macro <cctrl.h>]"
		alias
			"TCIF_TEXT"
		end

	Tcif_image: INTEGER is
			-- The iImage member is valid.
		external
			"C [macro <cctrl.h>]"
		alias
			"TCIF_IMAGE"
		end

	Tcif_rtlreading: INTEGER is
			-- Windows 95 only: Displays the text of pszText
			-- using right-to-left reading order on Hebrew or
			-- Arabic systems.
		external
			"C [macro <cctrl.h>]"
		alias
			"TCIF_RTLREADING"
		end

	Tcif_param: INTEGER is
			-- The lParam member is valid.
		external
			"C [macro <cctrl.h>]"
		alias
			"TCIF_PARAM"
		end

	Tcif_state: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TCIF_STATE"
		end

end -- class WEL_TCIF_CONSTANTS

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
