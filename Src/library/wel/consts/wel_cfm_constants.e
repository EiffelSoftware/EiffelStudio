indexing
	description: "Char format mask (CFM) constants for the rich edit %
		%control."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CFM_CONSTANTS

feature -- Access

	Cfm_bold: INTEGER is 1
			-- The CFE_BOLD value of the dwEffects member is valid.

	Cfm_italic: INTEGER is 2
			-- The CFE_ITALIC value of the dwEffects member is
			-- valid.

	Cfm_underline: INTEGER is 4
			-- The CFE_UNDERLINE value of the dwEffects member is
			-- valid.

	Cfm_strikeout: INTEGER is 8
			-- The CFE_STRIKEOUT value of the dwEffects member is
			-- valid.

	Cfm_protected: INTEGER is 16
			-- The CFE_PROTECTED value of the dwEffects member is
			-- valid.

	Cfm_color: INTEGER is 1073741824
			-- The crTextColor member and the CFE_AUTOCOLOR value
			-- of the dwEffects member are valid.

	Cfm_face: INTEGER is 536870912
			-- The szFaceName member is valid.

	Cfm_offset: INTEGER is 268435456
			-- The yOffset member is valid.

	Cfm_size: INTEGER is -2147483648
			-- The yHeight member is valid.

	Cfm_charset: INTEGER is 134217728
			-- The bCharSet member is valid.

end -- class WEL_CFM_CONSTANTS


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

