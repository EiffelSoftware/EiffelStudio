indexing
	description: "Edit Notification mask (ENM) constants for the rich %
		%edit control."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_ENM_CONSTANTS

feature -- Access

	Enm_none: INTEGER is
		external
			"C [macro <redit.h>]"
		alias
			"ENM_NONE"
		end

	Enm_change: INTEGER is
		external
			"C [macro <redit.h>]"
		alias
			"ENM_CHANGE"
		end

	Enm_update: INTEGER is
		external
			"C [macro <redit.h>]"
		alias
			"ENM_UPDATE"
		end

	Enm_scroll: INTEGER is
		external
			"C [macro <redit.h>]"
		alias
			"ENM_SCROLL"
		end

	Enm_keyevents: INTEGER is
		external
			"C [macro <redit.h>]"
		alias
			"ENM_KEYEVENTS"
		end

	Enm_mouseevents: INTEGER is
		external
			"C [macro <redit.h>]"
		alias
			"ENM_MOUSEEVENTS"
		end

	Enm_requestresize: INTEGER is
		external
			"C [macro <redit.h>]"
		alias
			"ENM_REQUESTRESIZE"
		end

	Enm_selchange: INTEGER is
		external
			"C [macro <redit.h>]"
		alias
			"ENM_SELCHANGE"
		end

	Enm_dropfiles: INTEGER is
		external
			"C [macro <redit.h>]"
		alias
			"ENM_DROPFILES"
		end

	Enm_protected: INTEGER is
		external
			"C [macro <redit.h>]"
		alias
			"ENM_PROTECTED"
		end

	Enm_correcttext: INTEGER is
		external
			"C [macro <redit.h>]"
		alias
			"ENM_CORRECTTEXT"
		end

	Enm_imechange: INTEGER is
		external
			"C [macro <redit.h>]"
		alias
			"ENM_IMECHANGE"
		end

end -- class WEL_ENM_CONSTANTS

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
