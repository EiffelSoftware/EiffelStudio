indexing
	description: "Tab control notification (TCN) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TCN_CONSTANTS

feature -- Access

	Tcn_keydown: INTEGER is
			-- Notifies a tab control's parent window that a key
			-- has been pressed.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TCN_KEYDOWN"
		end

	Tcn_selchange: INTEGER is
			-- Notifies a tab control's parent window that the
			-- currently selected tab has changed.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TCN_SELCHANGE"
		end

	Tcn_selchanging: INTEGER is
			-- Notifies a tab control's parent window that the
			-- currently selected tab is about to change.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TCN_SELCHANGING"
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




end -- class WEL_TCN_CONSTANTS

