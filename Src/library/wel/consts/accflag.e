indexing
	description: "Constants for defining accelerator keys %
		%in WEL_ACCELERATOR."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_ACCELERATOR_FLAG_CONSTANTS

feature -- Access

	Falt: INTEGER is
			-- The ALT key must be held down when the accelerator
			-- key is pressed.
		external
			"C [macro <wel.h>]"
		alias
			"FALT"
		end

	Fcontrol: INTEGER is
			-- The CTRL key must be held down when the accelerator
			-- key is pressed.
		external
			"C [macro <wel.h>]"
		alias
			"FCONTROL"
		end

	Fnoinvert: INTEGER is
			-- Specifies that no top-level menu item is highlighted
			-- when the accelerator is used. If this flag is not
			-- specified, a top-level menu item will be
			-- highlighted, if possible, when the accelerator is
			-- used.
		external
			"C [macro <wel.h>]"
		alias
			"FNOINVERT"
		end

	Fshift: INTEGER is
			-- The SHIFT key must be held down when the accelerator
			-- key is pressed.
		external
			"C [macro <wel.h>]"
		alias
			"FSHIFT"
		end

	Fvirtkey: INTEGER is
			-- The key member specifies a virtual-key code. If this
			-- flag is not specified, key is assumed to specify an
			-- ASCII character code.
		external
			"C [macro <wel.h>]"
		alias
			"FVIRTKEY"
		end

end -- class WEL_ACCELERATOR_FLAG_CONSTANTS

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
