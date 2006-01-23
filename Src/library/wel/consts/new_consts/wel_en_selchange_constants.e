indexing
	description: "Constants applicable to EN_SELCHANGE notification message."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_EN_SELCHANGE_CONSTANTS

feature -- Access

	Sel_empty: INTEGER is 0
		-- corresponds to SEL_EMPTY.
		
	Sel_text: INTEGER is 1
		-- corresponds to SEL_TEXT.
		
	Sel_object: INTEGER is 2
		-- Corresponds to SEL_OBJECT.
		
	Sel_multi_char: INTEGER is 4
		-- Corresponds to SEL_MULTICHAR.
		
	Sel_multi_object: INTEGER is 8;
		-- Corresponds to SEL_MULTIOBJECT


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




end -- class WEL_EN_SELCHANGE_CONSTANTS

