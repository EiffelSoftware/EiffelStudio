indexing
	description: "Constants for defining type of text search"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_FIND_FLAGS_CONSTANTS

feature -- Access

	Fr_matchcase: INTEGER is
			-- Case sensitive search
		external
			"C [macro %"wel.h%"]"
		alias
			"FR_MATCHCASE"
		end

	Fr_wholeword: INTEGER is
			-- Whole word search
		external
			"C [macro %"wel.h%"]"
		alias
			"FR_WHOLEWORD"
		end

end -- class WEL_FIND_FLAGS_CONSTANTS

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, ISE Building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
