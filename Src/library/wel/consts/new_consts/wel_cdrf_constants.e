indexing
	description: "Objects that provide access to Windows CDRF%
		%constants used with custom draw."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CDRF_CONSTANTS

feature -- Access

	cdrf_dodefault: INTEGER is 0
		-- Declared in Windows as CDRF_DODEFAULT.
		
	cdrf_newfont: INTEGER is 2
		-- Declared in Windows as CDRF_NEWFONT.
		
	cdrf_skipdefault: INTEGER is 4
		-- Declared in Windows as CDRF_SKIPDEFAULT.
		
	cdrf_notifypostpaint: INTEGER is 16
		-- Declared in Windows as CDRF_NOTIFYPOSTPAINT.
		
	cdrf_notifyitemdraw: INTEGER is 32
		-- Declared in Windows as CDRF_NOTIFYITEMDRAW.
		-- Identical to `cdrf_notifyitemsubdraw', distinguished
		-- by context.
		
	cdrf_notifyitemsubdraw: INTEGER is 32
		-- Declared in Windows as CDRF_NOTIFYSUBITEMDRAW
		-- Identical to `cdrf_notifyitemdraw', distinguished
		-- by context.
		
	cdrf_notifyposterase: INTEGER is 64;
		-- Declared in Windows as CDRF_NOTIFYPOSTERASE.
		
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




end -- class WEL_CDRF_CONSTANTS

