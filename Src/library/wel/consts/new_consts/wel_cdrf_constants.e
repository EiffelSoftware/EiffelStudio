indexing
	description: "Objects that provide access to Windows CDRF%
		%constants used with custom draw."
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
		
	cdrf_notifyposterase: INTEGER is 64
		-- Declared in Windows as CDRF_NOTIFYPOSTERASE.
		
end -- class WEL_CDRF_CONSTANTS

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------
