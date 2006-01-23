indexing
	description: "WEL_HEADER_CONTROL styles."
	legal: "See notice at end of class."
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




end -- class WEL_HDM_CONSTANTS

