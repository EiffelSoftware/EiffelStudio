indexing
	description: "Button notification (BN) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_BN_CONSTANTS

feature -- Access

	Bn_clicked: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"BN_CLICKED"
		end

	Bn_paint: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"BN_PAINT"
		end

	Bn_hilite: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"BN_HILITE"
		end

	Bn_unhilite: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"BN_UNHILITE"
		end

	Bn_disable: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"BN_DISABLE"
		end

	Bn_doubleclicked: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"BN_DOUBLECLICKED"
		end

end -- class WEL_BN_CONSTANTS

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
