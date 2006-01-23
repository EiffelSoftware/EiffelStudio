indexing
	description: "System Command (SC) constants for the Wm_syscommand %
		%message."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SC_CONSTANTS

feature -- Access

	Sc_size: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SC_SIZE"
		end

	Sc_move: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SC_MOVE"
		end

	Sc_minimize: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SC_MINIMIZE"
		end

	Sc_maximize: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SC_MAXIMIZE"
		end

	Sc_nextwindow: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SC_NEXTWINDOW"
		end

	Sc_prevwindow: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SC_PREVWINDOW"
		end

	Sc_close: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SC_CLOSE"
		end

	Sc_vscroll: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SC_VSCROLL"
		end

	Sc_hscroll: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SC_HSCROLL"
		end

	Sc_mousemenu: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SC_MOUSEMENU"
		end

	Sc_keymenu: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SC_KEYMENU"
		end

	Sc_arrange: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SC_ARRANGE"
		end

	Sc_restore: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SC_RESTORE"
		end

	Sc_tasklist: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SC_TASKLIST"
		end

	Sc_screensave: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SC_SCREENSAVE"
		end

	Sc_hotkey: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SC_HOTKEY"
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




end -- class WEL_SC_CONSTANTS

