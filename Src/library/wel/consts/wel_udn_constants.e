indexing
	description: "Up-down control notification (UDN) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_UDN_CONSTANTS

feature -- Access

	Udn_deltapos: INTEGER is
			-- The operating system sends the UDN_DELTAPOS
			-- notification message to the parent window of an
			-- up-down control when the position of the control is
			-- about to change.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"UDN_DELTAPOS"
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




end -- class WEL_UDN_CONSTANTS

