indexing
	description: "Choose color (CC) dialog constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CHOOSE_COLOR_CONSTANTS

feature -- Access

	Cc_rgbinit: INTEGER is
		external
			"C [macro <cdlg.h>]"
		alias
			"CC_RGBINIT"
		end

	Cc_fullopen: INTEGER is
		external
			"C [macro <cdlg.h>]"
		alias
			"CC_FULLOPEN"
		end

	Cc_preventfullopen: INTEGER is
		external
			"C [macro <cdlg.h>]"
		alias
			"CC_PREVENTFULLOPEN"
		end

	Cc_showhelp: INTEGER is
		external
			"C [macro <cdlg.h>]"
		alias
			"CC_SHOWHELP"
		end

	Cc_enablehook: INTEGER is
		external
			"C [macro <cdlg.h>]"
		alias
			"CC_ENABLEHOOK"
		end

	Cc_enabletemplate: INTEGER is
		external
			"C [macro <cdlg.h>]"
		alias
			"CC_ENABLETEMPLATE"
		end

	Cc_enabletemplatehandle: INTEGER is
		external
			"C [macro <cdlg.h>]"
		alias
			"CC_ENABLETEMPLATEHANDLE"
		end

end -- class WEL_CHOOSE_COLOR_CONSTANTS

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
