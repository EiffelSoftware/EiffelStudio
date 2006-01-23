indexing
	description	: "Mouse Activate (MA) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_MA_CONSTANTS

feature -- Access

	Ma_activate: INTEGER is 1
			-- Declared in Windows as MA_ACTIVATE

	Ma_activateandeat: INTEGER is 2
			-- Declared in Windows as MA_ACTIVATEANDEAT

	Ma_noactivate: INTEGER is 3
			-- Declared in Windows as MA_NOACTIVATE

	Ma_noactivateandeat: INTEGER is 4;
			-- Declared in Windows as MA_NOACTIVATEANDEAT

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




end -- class WEL_MA_CONSTANTS

