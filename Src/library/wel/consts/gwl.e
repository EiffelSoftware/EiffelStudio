indexing
	description: "GetWindowLong (GWL) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GWL_CONSTANTS

feature -- Access

	Gwl_exstyle: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"GWL_EXSTYLE"
		end

	Gwl_style: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"GWL_STYLE"
		end

	Gwl_wndproc: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"GWL_WNDPROC"
		end

end -- class WEL_GWL_CONSTANTS

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
