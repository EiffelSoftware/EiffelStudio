indexing
	description: "Mouse and Key (MK) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_MK_CONSTANTS

feature -- Access

	Mk_control: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MK_CONTROL"
		end

	Mk_lbutton: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MK_LBUTTON"
		end

	Mk_mbutton: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MK_MBUTTON"
		end

	Mk_rbutton: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MK_RBUTTON"
		end

	Mk_shift: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MK_SHIFT"
		end

end -- class WEL_MK_CONSTANTS

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

