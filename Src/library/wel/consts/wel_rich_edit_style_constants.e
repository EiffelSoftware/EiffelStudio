indexing
	description: "Rich edit styles."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_RICH_EDIT_STYLE_CONSTANTS

feature -- Access

	Es_disablenoscroll: INTEGER is 8192
			-- Disables scrollbars instead of hiding them when they
			-- are not needed.

	Es_noime: INTEGER is 524288
			-- Disables the input method editor (IME) operation.
			-- Available for Asian-languages only.

	Es_savesel: INTEGER is 32768
			-- Preserves the selection when the control loses the
			-- focus. By default, the entire contents of the
			-- control are selected when it regains the focus.

	Es_selfime: INTEGER is 262144
			-- Directs the rich edit control to allow the
			-- application to handle all IME operations.
			-- Available for Asian-languages only.

	Es_sunken: INTEGER is 16384
			-- Displays the control with a sunken border style so
			-- that the rich edit control appears recessed into
			-- its parent window. Applications developed for
			-- Windows 95 should use WS_EX_CLIENTEDGE instead of
			-- ES_SUNKEN.

	Es_vertical: INTEGER is 4194304
			-- Draws text and objects in a vertical direction.
			-- Available for Asian-languages only.

	Es_ex_nocalloleinit: INTEGER is 16777216
			-- Prevents the control from calling the OleInitialize function
			-- when created. This window style is useful only in dialog 
			-- templates because CreateWindowEx does not accept this style.
			--
			-- Declared in Windows as ES_EX_NOCALLOLEINIT

end -- class WEL_RICH_EDIT_STYLE_CONSTANTS

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

