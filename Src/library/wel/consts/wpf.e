indexing
	description: "WindowPlacement Flag (WPF) constant."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_WPF_CONSTANTS

feature -- Access

	Wpf_setminposition: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"WPF_SETMINPOSITION"
		end

	Wpf_restoretomaximized: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"WPF_RESTORETOMAXIMIZED"
		end

end -- class WEL_WPF_CONSTANTS

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
