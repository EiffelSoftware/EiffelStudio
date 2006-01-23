indexing
	description: "Char format mask underlinr (CFU) constants for the rich edit %
		%control."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CFU_CONSTANTS

feature -- Access

	Cfu_underline_none: INTEGER is 0
			-- Corresponds to CFU_UNDERLINENONE.
			
	Cfu_underline: INTEGER is 1
			-- Corresponds to CFU_UNDERLINE.
	
	Cfu_underline_word: INTEGER is 2
			-- Corresponds to CFU_UNDERLINEWORD.
			
	Cfu_underline_double: INTEGER is 3
			-- Corresponds to CFU_UNDERLINEDOUBLE.
			
	Cfu_underline_dotted: INTEGER is 4
			-- Corresponds to CFU_UNDERLINEDOTTED.

	Cfu_cf1_underline: INTEGER is 255;
			-- Corresponds to CFU_CF1UNDERLINE.

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




end -- class WEL_CFU_CONSTANTS

