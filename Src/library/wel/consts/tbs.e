indexing
	description: "Track Bar (common control) Style (TBS) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TBS_CONSTANTS

feature -- Access

	Tbs_autoticks: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TBS_AUTOTICKS"
		end

	Tbs_horz: INTEGER is 0
		--| Undocumented style

	Tbs_vert: INTEGER is 2
		--| Undocumented style

end -- class WEL_TBS_CONSTANTS

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
