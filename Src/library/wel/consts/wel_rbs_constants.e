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

