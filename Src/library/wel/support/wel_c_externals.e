indexing
	description: "Collections of windows externals."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_C_EXTERNALS
	
feature -- Focus related features

	frozen set_active_window (hwnd: POINTER): POINTER is
			-- Activates window `hwnd'. Returns handle of previously
			-- active window. If NULL, call `get_last_error' to get
			-- extended error information.
		external
			"C inline use <windows.h>"
		alias
			"SetActiveWindow ($hwnd)"
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




end
