indexing
	description: "Char format mask (CFM) constants for the rich edit %
		%control."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CFM_CONSTANTS

feature -- Access

	Cfm_bold: INTEGER is
			-- The CFE_BOLD value of the dwEffects member is valid.
		external
			"C [macro %"redit.h%"]"
		alias
			"CFM_BOLD"
		end

	Cfm_color: INTEGER is
			-- The crTextColor member and the CFE_AUTOCOLOR value
			-- of the dwEffects member are valid.
		external
			"C [macro %"redit.h%"]"
		alias
			"CFM_COLOR"
		end

	Cfm_face: INTEGER is
			-- The szFaceName member is valid.
		external
			"C [macro %"redit.h%"]"
		alias
			"CFM_FACE"
		end

	Cfm_italic: INTEGER is
			-- The CFE_ITALIC value of the dwEffects member is
			-- valid.
		external
			"C [macro %"redit.h%"]"
		alias
			"CFM_ITALIC"
		end

	Cfm_offset: INTEGER is
			-- The yOffset member is valid.
		external
			"C [macro %"redit.h%"]"
		alias
			"CFM_OFFSET"
		end

	Cfm_protected: INTEGER is
			-- The CFE_PROTECTED value of the dwEffects member is
			-- valid.
		external
			"C [macro %"redit.h%"]"
		alias
			"CFM_PROTECTED"
		end

	Cfm_size: INTEGER is
			-- The yHeight member is valid.
		external
			"C [macro %"redit.h%"]"
		alias
			"CFM_SIZE"
		end

	Cfm_strikeout: INTEGER is
			-- The CFE_STRIKEOUT value of the dwEffects member is
			-- valid.
		external
			"C [macro %"redit.h%"]"
		alias
			"CFM_STRIKEOUT"
		end

	Cfm_underline: INTEGER is
			-- The CFE_UNDERLINE value of the dwEffects member is
			-- valid.
		external
			"C [macro %"redit.h%"]"
		alias
			"CFM_UNDERLINE"
		end

	Cfm_charset: INTEGER is
			-- The bCharSet member is valid.
		external
			"C [macro %"redit.h%"]"
		alias
			"CFM_CHARSET"
		end

end -- class WEL_CFM_CONSTANTS

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

