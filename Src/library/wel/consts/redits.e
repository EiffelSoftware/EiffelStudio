indexing
	description: "Rich edit styles."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_RICH_EDIT_STYLE_CONSTANTS

feature -- Access

	Es_disablenoscroll: INTEGER is
			-- Disables scrollbars instead of hiding them when they
			-- are not needed.
		external
			"C [macro <redit.h>]"
		alias
			"ES_DISABLENOSCROLL"
		end

	Es_ex_nocalloleinit: INTEGER is
			-- Prevents the control from calling the OleInitialize
			-- function when created. Useful only in dialog
			-- templates because CreateWindowEx does not accept
			-- this style.
		external
			"C [macro <redit.h>]"
		alias
			"ES_EX_NOCALLOLEINIT"
		end

	Es_noime: INTEGER is
			-- Disables the input method editor (IME) operation.
			-- Available for Asian-languages only.
		external
			"C [macro <redit.h>]"
		alias
			"ES_NOIME"
		end

	Es_savesel: INTEGER is
			-- Preserves the selection when the control loses the
			-- focus. By default, the entire contents of the
			-- control are selected when it regains the focus.
		external
			"C [macro <redit.h>]"
		alias
			"ES_SAVESEL"
		end

	Es_selfime: INTEGER is
			-- Directs the rich edit control to allow the
			-- application to handle all IME operations.
			-- Available for Asian-languages only.
		external
			"C [macro <redit.h>]"
		alias
			"ES_SELFIME"
		end

	Es_sunken: INTEGER is
			-- Displays the control with a sunken border style so
			-- that the rich edit control appears recessed into
			-- its parent window. Applications developed for
			-- Windows 95 should use WS_EX_CLIENTEDGE instead of
			-- ES_SUNKEN.
		external
			"C [macro <redit.h>]"
		alias
			"ES_SUNKEN"
		end

	Es_vertical: INTEGER is
			-- Draws text and objects in a vertical direction.
			-- Available for Asian-languages only.
		external
			"C [macro <redit.h>]"
		alias
			"ES_VERTICAL"
		end

end -- class WEL_RICH_EDIT_STYLE_CONSTANTS

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
