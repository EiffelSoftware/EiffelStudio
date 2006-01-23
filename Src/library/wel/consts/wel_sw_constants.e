indexing
	description: "ShowWindow (SW) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SW_CONSTANTS

feature -- Access

	Sw_hide: INTEGER is 0
			-- Declared in Windows as SW_HIDE

	Sw_minimize: INTEGER is 6
			-- Declared in Windows as SW_MINIMIZE

	Sw_restore: INTEGER is 9
			-- Declared in Windows as SW_RESTORE

	Sw_shownormal: INTEGER is 1
			-- Declared in Windows as SW_SHOWNORMAL

	Sw_show: INTEGER is 5
			-- Declared in Windows as SW_SHOW

	Sw_showmaximized: INTEGER is 3
			-- Declared in Windows as SW_SHOWMAXIMIZED

	Sw_showminimized: INTEGER is 2
			-- Declared in Windows as SW_SHOWMINIMIZED

	Sw_showminnoactive: INTEGER is 7
			-- Declared in Windows as SW_SHOWMINNOACTIVE

	Sw_showna: INTEGER is 8
			-- Declared in Windows as SW_SHOWNA

	Sw_shownoactivate: INTEGER is 4
			-- Declared in Windows as SW_SHOWNOACTIVATE

	Sw_parentclosing: INTEGER is 1
			-- Declared in Windows as SW_PARENTCLOSING

	Sw_parentopening: INTEGER is 3
			-- Declared in Windows as SW_PARENTOPENING

	Sw_otherzoom: INTEGER is 2
			-- Declared in Windows as SW_OTHERZOOM

	Sw_otherunzoom: INTEGER is 4;
			-- Declared in Windows as SW_OTHERUNZOOM

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




end -- class WEL_SW_CONSTANTS

