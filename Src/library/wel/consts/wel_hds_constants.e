indexing
	description: "WEL_HEADER_CONTROL styles."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_HDS_CONSTANTS

feature -- Access
 
	Hds_buttons: INTEGER is
			-- Header items behave like buttons. 
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDS_BUTTONS"
		end

	Hds_hidden: INTEGER is
			-- Indicates a header control that is intended to be hidden. 
			-- This style does not hide the control; instead, it causes the 
			-- header control to return zero in the cy member of the WINDOWPOS 
			-- structure returned by an HDM_LAYOUT message. You would then hide 
			-- the control by setting its height to zero. 
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDS_HIDDEN"
		end

	Hds_horz: INTEGER is
			-- The header control is horizontal.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDS_HORZ"
		end

end -- class WEL_HDM_CONSTANTS

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

