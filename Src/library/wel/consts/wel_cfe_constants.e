indexing
	description: "Char format effect (CFE) constants for the rich edit %
		%control."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CFE_CONSTANTS

feature -- Access

	Cfe_bold: INTEGER is 1
			-- Characters are bold.

	Cfe_italic: INTEGER is 2
			-- Characters are italic.

	Cfe_underline: INTEGER is 4
			-- Characters are underlined.

	Cfe_strikeout: INTEGER is 8
			-- Characters are struck out.

	Cfe_protected: INTEGER is 16
			-- Characters are protected; an attempt to modify them
			-- will cause an EN_PROTECTED notification message.

	Cfe_autocolor: INTEGER is 1073741824
			-- The text color is the return value of
			-- GetSysColor (COLOR_WINDOWTEXT).

end -- class WEL_CFE_CONSTANTS


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

