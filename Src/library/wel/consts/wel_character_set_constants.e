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

