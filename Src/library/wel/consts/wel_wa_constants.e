indexing
	description: "Window activation (WA) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_WA_CONSTANTS

feature -- Access

	Wa_active: INTEGER is 1
			-- Window gains activation via alt-tab

	Wa_clickactive: INTEGER is 2
			-- Window gains activation via mouse click

	Wa_inactivate: INTEGER is 0;
			-- Window loses activation

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




end -- class WEL_WS_CONSTANTS

