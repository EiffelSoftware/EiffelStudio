indexing
	description: "Static style (SS) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SS_CONSTANTS

feature -- Access

	Ss_left: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SS_LEFT"
		end

	Ss_center: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SS_CENTER"
		end

	Ss_right: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SS_RIGHT"
		end

	Ss_icon: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SS_ICON"
		end

	Ss_blackrect: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SS_BLACKRECT"
		end

	Ss_grayrect: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SS_GRAYRECT"
		end

	Ss_whiterect: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SS_WHITERECT"
		end

	Ss_blackframe: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SS_BLACKFRAME"
		end

	Ss_grayframe: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SS_GRAYFRAME"
		end

	Ss_whiteframe: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SS_WHITEFRAME"
		end

	Ss_simple: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SS_SIMPLE"
		end

	Ss_leftnowordwrap: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SS_LEFTNOWORDWRAP"
		end

	Ss_noprefix: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SS_NOPREFIX"
		end

end -- class WEL_SS_CONSTANTS

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
