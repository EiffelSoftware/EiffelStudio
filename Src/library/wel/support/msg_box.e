indexing
	description: "Interface on the MessageBox function."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_MESSAGE_BOX

feature -- Basic operations

	message_box (a_text, a_title: STRING; a_style: INTEGER) is
			-- Show a message box with `a_text' inside and
			-- `a_title' using `a_style'.
			-- See class WEL_MB_CONSTANTS for `a_style' value.
		require
			text_not_void: a_text /= Void
			title_not_void: a_title /= Void
		local
			a1, a2: ANY
		do
			a1 := a_text.to_c
			a2 := a_title.to_c
			message_box_result := cwin_message_box (default_pointer,
				$a1, $a2, a_style)
		end

	error_message_box (a_text: STRING; a_style: INTEGER) is
			-- Show a error message box with `a_text'
			-- inside using `a_style'.
			-- See class WEL_MB_CONSTANTS for `a_style' value.
		require
			text_not_void: a_text /= Void
		local
			a1: ANY
		do
			a1 := a_text.to_c
			message_box_result := cwin_message_box (default_pointer,
				$a1, default_pointer, a_style)
		end

feature -- Status report

	message_box_result: INTEGER
			-- Last result for the `message_box' and
			-- `error_message_box' routines.
			-- See class WEL_ID_CONSTANTS for values.

feature {NONE} -- Externals

	cwin_message_box (hwnd, a_text, a_title: POINTER;
			a_style: INTEGER): INTEGER is
			-- SDK MessageBox
		external
			"C [macro <wel.h>] (HWND, LPCSTR, LPCSTR, %
				%UINT): EIF_INTEGER"
		alias
			"MessageBox"
		end

end -- class WEL_MESSAGE_BOX

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
