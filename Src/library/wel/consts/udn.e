indexing
	description: "Up-down control notification (UDN) constants."
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
			"C [macro <cctrl.h>]"
		alias
			"UDN_DELTAPOS"
		end

end -- class WEL_UDN_CONSTANTS

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
