indexing
	description: "Text Alignment (TA) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TA_CONSTANTS

feature -- Access

	Ta_noupdatecp: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"TA_NOUPDATECP"
		end

	Ta_updatecp: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"TA_UPDATECP"
		end

	Ta_left: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"TA_LEFT"
		end

	Ta_right: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"TA_RIGHT"
		end

	Ta_center: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"TA_CENTER"
		end

	Ta_top: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"TA_TOP"
		end

	Ta_bottom: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"TA_BOTTOM"
		end

	Ta_baseline: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"TA_BASELINE"
		end

end -- class WEL_TA_CONSTANTS

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
