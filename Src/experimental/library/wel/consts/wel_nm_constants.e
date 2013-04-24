note
	description: "Windows Notification Message (NM) constants"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_NM_CONSTANTS

feature -- Access

	Nm_outofmemory: INTEGER = -1
		-- Declared_in Windows as NM_OUTOF_MEMORY
	
	Nm_click: INTEGER = -2
		-- Declared_in Windows as NM_CLICK
		
	Nm_dblclk: INTEGER = -3
		-- Declared_in Windows as NM_DBLCLK
		
	Nm_return : INTEGER = -4
		-- Declared_in Windows as NM_RETURN
		
	Nm_rclick: INTEGER = -5
		-- Declared_in Windows as NM_RCLICK
		
	Nm_rdblck: INTEGER = -6
		-- Declared_in Windows as NM_RDBLCLK
		
	Nm_setfocus: INTEGER = -7
		-- Declared_in Windows as NM_SETFOCUS
		
	Nm_killfocus: INTEGER = -8
		-- Declared_in Windows as NM_KILLFOCUS
		
	Nm_customdraw: INTEGER = -12 
		-- Declared_in Windows as NM_CUSTOMDRAW
		
	Nm_hover: INTEGER = -13
		-- Declared_in Windows as NM_HOVER
		
	Nm_nchittest: INTEGER = -14
		-- Declared_in Windows as NM_NCHITTEST
		
	Nm_keydown: INTEGER = -15
		-- Declared_in Windows as NM_KEYDOWN
		
	Nm_releasedcapture: INTEGER = -16
		-- Declared_in Windows as NM_RELEASEDCAPTURE
		
	Nm_setcursor: INTEGER = -17
		-- Declared_in Windows as NM_SETCURSOR
		
	Nm_char: INTEGER = -18
		-- Declared_in Windows as NM_CHAR

	Nm_tooltipscreated: INTEGER = -19
		-- Declared_in Windows as NM_TOOLTIPSCREATED
		
	Nm_ldown: INTEGER = -20
		-- Declared_in Windows as NM_LDOWN
	
	Nm_rdown: INTEGER = -21;
		-- Declared_in Windows as NM_RDOWN

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




end -- class WEL_NM_CONSTANTS
