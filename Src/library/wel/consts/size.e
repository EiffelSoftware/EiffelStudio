indexing
	description: "Size (SIZE) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SIZE_CONSTANTS

feature -- Access

	Size_maximized: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SIZE_MAXIMIZED"
		end

	Size_minimized: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SIZE_MINIMIZED"
		end

	Size_restored: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SIZE_RESTORED"
		end

	Size_maxhide: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SIZE_MAXHIDE"
		end

	Size_maxshow: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SIZE_MAXSHOW"
		end

end -- class WEL_SIZE_CONSTANTS

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
