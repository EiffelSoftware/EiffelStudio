indexing
	description: "Rebar Band Style (RBBS) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_RBBS_CONSTANTS

feature -- Access

	Rbbs_break: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RBBS_BREAK"
		end

	Rbbs_fixedsize: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RBBS_FIXEDSIZE"
		end

	Rbbs_childedge: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RBBS_CHILDEDGE"
		end

	Rbbs_hidden: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RBBS_HIDDEN"
		end

	Rbbs_novert: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RBBS_NOVERT"
		end

	Rbbs_fixedbmp: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RBBS_FIXEDBMP"
		end

end -- class WEL_RBBS_CONSTANTS


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

