indexing
	description: "Character set constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CHARACTER_SET_CONSTANTS

feature -- Access 

	Ansi_charset: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"ANSI_CHARSET"
		end

	Default_charset: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"DEFAULT_CHARSET"
		end

	Symbol_charset: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SYMBOL_CHARSET"
		end

	Shiftjis_charset: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SHIFTJIS_CHARSET"
		end

	Hangeul_charset: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"HANGEUL_CHARSET"
		end

	Chinesebig5_charset: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"CHINESEBIG5_CHARSET"
		end

	Oem_charset: INTEGER is
			-- (is operating-system dependent)
		external
			"C [macro <wel.h>]"
		alias
			"OEM_CHARSET"
		end

	Unicode_charset: INTEGER is 1
			--| Not defined in windows.h

end -- class WEL_CHARACTER_SET_CONSTANTS

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
