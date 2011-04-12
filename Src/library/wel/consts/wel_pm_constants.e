note
	description: "PeekMessage (PM) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_PM_CONSTANTS

feature -- Access

	Pm_noremove: INTEGER = 0

	Pm_remove: INTEGER = 1

	Pm_noyield: INTEGER = 2;

	Pm_qs_input: INTEGER = 0x4070000;

	Pm_qs_paint: INTEGER = 0x200000

	Pm_qs_postmessage: INTEGER = 0x980000;

	Pm_qs_sendmessage: INTEGER = 0x400000;

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




end -- class WEL_PM_CONSTANTS

