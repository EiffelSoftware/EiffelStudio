indexing
	description: "Common control ReBar Style (TBS) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_RBS_CONSTANTS

feature -- Access

	Rbs_tooltips: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RBS_TOOLTIPS"
		end

	Rbs_varheight: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RBS_VARHEIGHT"
		end

	Rbs_bandborders: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RBS_BANDBORDERS"
		end

	Rbs_fixedorder: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RBS_FIXEDORDER"
		end

end -- class WEL_RBS_CONSTANTS


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

