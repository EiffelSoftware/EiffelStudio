note
	description: "Character set constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CHARACTER_SET_CONSTANTS

feature -- Access 

	Ansi_charset: INTEGER = 0

	Default_charset: INTEGER = 1

	Symbol_charset: INTEGER = 2

	Shiftjis_charset: INTEGER = 128

	Hangeul_charset: INTEGER = 129

	Chinesebig5_charset: INTEGER = 136

	Oem_charset: INTEGER = 255
			-- (is operating-system dependent)

	Unicode_charset: INTEGER = 1;
			--| Not defined in windows.h

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




end -- class WEL_CHARACTER_SET_CONSTANTS

