note
	description: "ListBox notification (LBN) messages."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_LBN_CONSTANTS

feature -- Access

	Lbn_errspace: INTEGER = -2

	Lbn_selchange: INTEGER = 1

	Lbn_dblclk: INTEGER = 2

	Lbn_selcancel: INTEGER = 3

	Lbn_setfocus: INTEGER = 4

	Lbn_killfocus: INTEGER = 5;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_LBN_CONSTANTS

