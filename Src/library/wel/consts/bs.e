indexing
	description: "Button style (BS) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_BS_CONSTANTS

feature -- Access

	Bs_pushbutton: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"BS_PUSHBUTTON"
		end

	Bs_defpushbutton: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"BS_DEFPUSHBUTTON"
		end

	Bs_checkbox: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"BS_CHECKBOX"
		end

	Bs_autocheckbox: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"BS_AUTOCHECKBOX"
		end

	Bs_radiobutton: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"BS_RADIOBUTTON"
		end

	Bs_3state: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"BS_3STATE"
		end

	Bs_auto3state: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"BS_AUTO3STATE"
		end

	Bs_groupbox: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"BS_GROUPBOX"
		end

	Bs_userbutton: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"BS_USERBUTTON"
		end

	Bs_autoradiobutton: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"BS_AUTORADIOBUTTON"
		end

	Bs_ownerdraw: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"BS_OWNERDRAW"
		end

	Bs_lefttext: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"BS_LEFTTEXT"
		end

end -- class WEL_BS_CONSTANTS

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
