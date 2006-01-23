indexing
	description: "Windows Notification Message (NM) constants"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_NM_CONSTANTS

feature -- Access

	Nm_outofmemory: INTEGER is -1
		-- Declared_in Windows as NM_OUTOF_MEMORY
	
	Nm_click: INTEGER is -2
		-- Declared_in Windows as NM_CLICK
		
	Nm_dblclk: INTEGER is -3
		-- Declared_in Windows as NM_DBLCLK
		
	Nm_return : INTEGER is -4
		-- Declared_in Windows as NM_RETURN
		
	Nm_rclick: INTEGER is -5
		-- Declared_in Windows as NM_RCLICK
		
	Nm_rdblck: INTEGER is -6
		-- Declared_in Windows as NM_RDBLCLK
		
	Nm_setfocus: INTEGER is -7
		-- Declared_in Windows as NM_SETFOCUS
		
	Nm_killfocus: INTEGER is -8
		-- Declared_in Windows as NM_KILLFOCUS
		
	Nm_customdraw: INTEGER is -12 
		-- Declared_in Windows as NM_CUSTOMDRAW
		
	Nm_hover: INTEGER is -13
		-- Declared_in Windows as NM_HOVER
		
	Nm_nchittest: INTEGER is -14
		-- Declared_in Windows as NM_NCHITTEST
		
	Nm_keydown: INTEGER is -15
		-- Declared_in Windows as NM_KEYDOWN
		
	Nm_releasedcapture: INTEGER is -16
		-- Declared_in Windows as NM_RELEASEDCAPTURE
		
	Nm_setcursor: INTEGER is -17
		-- Declared_in Windows as NM_SETCURSOR
		
	Nm_char: INTEGER is -18
		-- Declared_in Windows as NM_CHAR

	Nm_tooltipscreated: INTEGER is -19
		-- Declared_in Windows as NM_TOOLTIPSCREATED
		
	Nm_ldown: INTEGER is -20
		-- Declared_in Windows as NM_LDOWN
	
	Nm_rdown: INTEGER is -21;
		-- Declared_in Windows as NM_RDOWN

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




end -- class WEL_NM_CONSTANTS
