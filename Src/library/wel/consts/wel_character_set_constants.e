indexing
	description: "Character set constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CHARACTER_SET_CONSTANTS

feature -- Access 

	Ansi_charset: INTEGER is 0

	Default_charset: INTEGER is 1

	Symbol_charset: INTEGER is 2

	Shiftjis_charset: INTEGER is 128

	Hangeul_charset: INTEGER is 129

	Chinesebig5_charset: INTEGER is 136

	Oem_charset: INTEGER is 255
			-- (is operating-system dependent)

	Unicode_charset: INTEGER is 1
			--| Not defined in windows.h

end -- class WEL_CHARACTER_SET_CONSTANTS

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

