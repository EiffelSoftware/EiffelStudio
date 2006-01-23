indexing
	description: "Generic message information."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_MESSAGE_INFORMATION

inherit
	ANY

	WEL_WORD_OPERATIONS
		export
			{NONE} all
		end

create
	make

feature -- Initialization

	make (a_window: WEL_WINDOW; a_message: INTEGER; a_w_param, a_l_param: POINTER) is
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

	w_param: POINTER
			-- Additional information about `message'. The exact
			-- meaning depends on the value of `message'.

	l_param: POINTER
			-- Additional information about `message'. The exact
			-- meaning depends on the value of `message'.

feature {NONE} -- Externals

	x_position_from_lparam (lparam: POINTER): INTEGER is
		external
			"C inline use <windows.h>"
		alias
			"((int)(short)LOWORD($lparam))"
		end

	y_position_from_lparam (lparam: POINTER): INTEGER is
		external
			"C inline use <windows.h>"
		alias
			"((int)(short)HIWORD($lparam))"
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




end -- class WEL_MESSAGE_INFORMATION

