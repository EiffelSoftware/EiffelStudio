indexing
	description: "Edit control notification (EN) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_EN_CONSTANTS

feature -- Access

	En_setfocus: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"EN_SETFOCUS"
		end

	En_killfocus: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"EN_KILLFOCUS"
		end

	En_change: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"EN_CHANGE"
		end

	En_update: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"EN_UPDATE"
		end

	En_errspace: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"EN_ERRSPACE"
		end

	En_maxtext: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"EN_MAXTEXT"
		end

	En_hscroll: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"EN_HSCROLL"
		end

	En_vscroll: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"EN_VSCROLL"
		end

end -- class WEL_EN_CONSTANTS

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
