indexing
	description: "Tree view notification (TVN) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TVN_CONSTANTS

feature -- Access

	Tvn_begindrag: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TVN_BEGINDRAG"
		end

	Tvn_beginlabeledit: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TVN_BEGINLABELEDIT"
		end

	Tvn_beginrdrag: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TVN_BEGINRDRAG"
		end

	Tvn_deleteitem: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TVN_DELETEITEM"
		end

	Tvn_endlabeledit: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TVN_ENDLABELEDIT"
		end

	Tvn_getdispinfo: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TVN_GETDISPINFO"
		end

	Tvn_itemexpanded: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TVN_ITEMEXPANDED"
		end

	Tvn_itemexpanding: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TVN_ITEMEXPANDING"
		end

	Tvn_keydown: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TVN_KEYDOWN"
		end

	Tvn_selchanged: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TVN_SELCHANGED"
		end

	Tvn_selchanging: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TVN_SELCHANGING"
		end

	Tvn_setdispinfo: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TVN_SETDISPINFO"
		end

end -- class WEL_TVN_CONSTANTS

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
