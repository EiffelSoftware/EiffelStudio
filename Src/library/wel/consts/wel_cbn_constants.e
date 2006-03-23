indexing
	description	: "ComboBox notification message (CBN) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_CBN_CONSTANTS

obsolete
	"Use WEL_COMBO_BOX_CONSTANTS instead."

feature -- Access

	Cbn_errspace: INTEGER is -1
			-- Declared in Windows as CBN_ERRSPACE

	Cbn_selchange: INTEGER is 1
			-- Declared in Windows as CBN_SELCHANGE

	Cbn_dblclk: INTEGER is 2
			-- Declared in Windows as CBN_DBLCLK

	Cbn_setfocus: INTEGER is 3
			-- Declared in Windows as CBN_SETFOCUS

	Cbn_killfocus: INTEGER is 4
			-- Declared in Windows as CBN_KILLFOCUS

	Cbn_editchange: INTEGER is 5
			-- Declared in Windows as CBN_EDITCHANGE

	Cbn_editupdate: INTEGER is 6
			-- Declared in Windows as CBN_EDITUPDATE

	Cbn_dropdown: INTEGER is 7
			-- Declared in Windows as CBN_DROPDOWN

	Cbn_closeup: INTEGER is 8
			-- Declared in Windows as CBN_CLOSEUP

	Cbn_selendok: INTEGER is 9
			-- Declared in Windows as CBN_SELENDOK

	Cbn_selendcancel: INTEGER is 10;
			-- Declared in Windows as CBN_SELENDCANCEL

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




end -- class WEL_CBN_CONSTANTS

