indexing
	description: "Generic message information."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_MESSAGE_INFORMATION

inherit
	WEL_WORD_OPERATIONS
		export
			{NONE} all
		end

creation
	make

feature -- Initialization

	make (a_window: WEL_WINDOW; a_message, a_w_param, a_l_param: INTEGER) is
			-- Set `window', `message', `w_param', `l_param' with
			-- `a_window', `a_message', `a_w_param', `a_l_param'
		do
			window := a_window
			message := a_message
			w_param := a_w_param
			l_param := a_l_param
		ensure
			window_set: window = a_window
			message_set: message = a_message
			w_param_set: w_param = a_w_param
			l_param_set: l_param = a_l_param
		end

feature -- Access

	window: WEL_WINDOW
			-- Window which receives `message'

	message: INTEGER
			-- Message number. See class WEL_WM_CONSTANTS for
			-- different values.

	w_param: INTEGER
			-- Additional information about `message'. The exact
			-- meaning depends on the value of `message'.

	l_param: INTEGER
			-- Additional information about `message'. The exact
			-- meaning depends on the value of `message'.

end -- class WEL_MESSAGE_INFORMATION


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

