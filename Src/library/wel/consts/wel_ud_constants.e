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
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

