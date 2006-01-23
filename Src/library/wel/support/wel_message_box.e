indexing
	description: "Interface on the MessageBox function."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
class
	WEL_MESSAGE_BOX

obsolete
	"Use WEL_MSG_BOX instead"

feature -- Basic operations

	message_box (a_text, a_title: STRING; a_style: INTEGER) is
			-- Show a message box with `a_text' inside and
			-- `a_title' using `a_style'.
			-- See class WEL_MB_CONSTANTS for `a_style' value.
		require
			text_not_void: a_text /= Void
			title_not_void: a_title /= Void
		local
			a_wel_string1, a_wel_string2: WEL_STRING
		do
			create a_wel_string1.make (a_text)
			create a_wel_string2.make (a_title)
			message_box_result := cwin_message_box (default_pointer,
				a_wel_string1.item, a_wel_string2.item, a_style)
		end

	error_message_box (a_text: STRING; a_style: INTEGER) is
			-- Show a error message box with `a_text'
			-- inside using `a_style'.
			-- See class WEL_MB_CONSTANTS for `a_style' value.
		require
			text_not_void: a_text /= Void
		local
			a_wel_string: WEL_STRING
		do
			create a_wel_string.make (a_text)
			message_box_result := cwin_message_box (default_pointer,
				a_wel_string.item, default_pointer, a_style)
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_MESSAGE_BOX

