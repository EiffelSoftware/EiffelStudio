indexing
	description: "SetWindowPosition (SWP) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SWP_CONSTANTS

feature -- Access

	Swp_nosize: INTEGER is 1

	Swp_nomove: INTEGER is 2

	Swp_nozorder: INTEGER is 4

	Swp_noredraw: INTEGER is 8

	Swp_noactivate: INTEGER is 16

	Swp_framechanged: INTEGER is 32
			-- Frame changed: send WM_NCCALCSIZE.

	Swp_showwindow: INTEGER is 64

	Swp_hidewindow: INTEGER is 128

	Swp_nocopybits: INTEGER is 256

	Swp_noownerzorder: INTEGER is 512

	Swp_drawframe: INTEGER is 32
			-- Same as `Swp_drawframe'.

	Swp_nosendchanging: INTEGER is 1024
			-- Don't send WM_WINDOWPOSCHANGING.

	Swp_noreposition: INTEGER is 512;
			-- Same as `Swp_noownerzborder'.

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




end -- class WEL_SWP_CONSTANTS

