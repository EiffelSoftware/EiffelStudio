indexing
	description: "Up-down control (UD) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_UD_CONSTANTS

feature -- Access

	Ud_maxval: INTEGER is 32767
			-- Maximum value allowed in an up-down control.
			--
			-- Declared in Windows as UD_MAXVAL

	Ud_minval: INTEGER is -32767
			-- Minimum value allowed in an up-down control.
			--
			-- Declared in Windows as UD_MINVAL

end -- class WEL_UD_CONSTANTS

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

