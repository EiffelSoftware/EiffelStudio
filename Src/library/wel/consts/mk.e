indexing
	description: "Mouse and Key (MK) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_MK_CONSTANTS

feature -- Access

	Mk_control: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"MK_CONTROL"
		end

	Mk_lbutton: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"MK_LBUTTON"
		end

	Mk_mbutton: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"MK_MBUTTON"
		end

	Mk_rbutton: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"MK_RBUTTON"
		end

	Mk_shift: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"MK_SHIFT"
		end

end -- class WEL_MK_CONSTANTS

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
