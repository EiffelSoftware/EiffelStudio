indexing
	description: "GetWindow (GW) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GW_CONSTANTS

feature -- Access

	Gw_hwndfirst: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"GW_HWNDFIRST"
		end

	Gw_hwndlast: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"GW_HWNDLAST"
		end

	Gw_hwndnext: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"GW_HWNDNEXT"
		end

	Gw_hwndprev: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"GW_HWNDPREV"
		end

	Gw_owner: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"GW_OWNER"
		end

	Gw_child: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"GW_CHILD"
		end

end -- class WEL_GW_CONSTANTS

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
