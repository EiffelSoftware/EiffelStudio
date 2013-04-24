note
	description: "SetWindowPosition (SWP) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SWP_CONSTANTS

feature -- Access

	Swp_nosize: INTEGER = 0x1

	Swp_nomove: INTEGER = 0x2

	Swp_nozorder: INTEGER = 0x4

	Swp_noredraw: INTEGER = 0x8

	Swp_noactivate: INTEGER = 0x10

	Swp_framechanged: INTEGER = 0x20
			-- Frame changed: send WM_NCCALCSIZE.

	Swp_showwindow: INTEGER = 0x40

	Swp_hidewindow: INTEGER = 0x80

	Swp_nocopybits: INTEGER = 0x100

	Swp_noownerzorder: INTEGER = 0x200

	Swp_drawframe: INTEGER = 0x20
			-- Same as `Swp_framechanged'.

	Swp_nosendchanging: INTEGER = 0x400
			-- Don't send WM_WINDOWPOSCHANGING.

	Swp_noreposition: INTEGER = 0x200
			-- Same as `Swp_noownerzborder'.

	swp_defererase: INTEGER = 0x2000
			-- Prevents generation of the WM_SYNCPAINT message.

	swp_asyncwindowpos: INTEGER = 0x4000;
			-- If the calling thread and the thread that owns the window are attached
			-- to different input queues, the system posts the request to the thread--
			-- that owns the window. This prevents the calling thread from blocking
			-- its execution while other threads process the request.

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




end -- class WEL_SWP_CONSTANTS

