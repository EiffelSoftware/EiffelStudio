indexing
	description: "Char format mask (CFM) constants for the rich edit %
		%control."
	legal: "See notice at end of class."
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
	
	Cfm_revauthor: INTEGER is 32768
			-- The bRevAuthor member is valid.
			
	Cfm_spacing: INTEGER is 2097152
			-- The sSpacing member is valid.
			
	Cfm_weight: INTEGER is 4194304
			-- The wWeight member is valid.
			
	Cfm_underlinetype: INTEGER is 8388608
			-- The bUnderlineType member is valid.

	Cfm_color: INTEGER is 1073741824
			-- The crTextColor member and the CFE_AUTOCOLOR value
			-- of the dwEffects member are valid.

	Cfm_face: INTEGER is 536870912
			-- The szFaceName member is valid.

	Cfm_offset: INTEGER is 268435456
			-- The yOffset member is valid.

	Cfm_size: INTEGER is -2147483648
			-- The yHeight member is valid.
			
	Cfm_backcolor: INTEGER is 67108864
			-- The crBackColor member is valid

	Cfm_charset: INTEGER is 134217728;
			-- The bCharSet member is valid.

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




end -- class WEL_CFM_CONSTANTS

