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
			
	Cfe_autobackcolor: INTEGER is 67108864
			-- The text background color is the value
			-- of the containing control.

end -- class WEL_CFE_CONSTANTS

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

