indexing
	description: "Button messages (BM) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_BM_CONSTANTS

feature -- Access

	Bm_getcheck: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"BM_GETCHECK"
		end

	Bm_setcheck: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"BM_SETCHECK"
		end

	Bm_getstate: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"BM_GETSTATE"
		end

	Bm_setstate: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"BM_SETSTATE"
		end

	Bm_setstyle: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"BM_SETSTYLE"
		end

end -- class WEL_BM_CONSTANTS

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

