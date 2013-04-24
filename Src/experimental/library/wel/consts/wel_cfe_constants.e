note
	description: "Char format effect (CFE) constants for the rich edit %
		%control."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CFE_CONSTANTS

feature -- Access

	Cfe_bold: INTEGER = 1
			-- Characters are bold.

	Cfe_italic: INTEGER = 2
			-- Characters are italic.

	Cfe_underline: INTEGER = 4
			-- Characters are underlined.

	Cfe_strikeout: INTEGER = 8
			-- Characters are struck out.

	Cfe_protected: INTEGER = 16
			-- Characters are protected; an attempt to modify them
			-- will cause an EN_PROTECTED notification message.

	Cfe_autocolor: INTEGER = 1073741824
			-- The text color is the return value of
			-- GetSysColor (COLOR_WINDOWTEXT).
			
	Cfe_autobackcolor: INTEGER = 67108864;
			-- The text background color is the value
			-- of the containing control.

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_CFE_CONSTANTS

