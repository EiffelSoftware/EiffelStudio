indexing
	description: "List view style (LVS) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_LVS_CONSTANTS

feature -- Access

	Lvs_alignleft: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVS_ALIGNLEFT"
		end

	Lvs_aligntop: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVS_ALIGNTOP"
		end

	Lvs_autoarrange: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVS_AUTOARRANGE"
		end

	Lvs_editlabels: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVS_EDITLABELS"
		end

	Lvs_icon: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVS_ICON"
		end

	Lvs_list: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVS_LIST"
		end

	Lvs_nocolumnheader: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVS_NOCOLUMNHEADER"
		end

	Lvs_nolabelwrap: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVS_NOLABELWRAP"
		end

	Lvs_noscroll: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVS_NOSCROLL"
		end

	Lvs_ownerdrawfixed: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVS_OWNERDRAWFIXED"
		end

	Lvs_report: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVS_REPORT"
		end

	Lvs_shareimagelists: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVS_SHAREIMAGELISTS"
		end

	Lvs_showselalways: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVS_SHOWSELALWAYS"
		end

	Lvs_singlesel: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVS_SINGLESEL"
		end

	Lvs_smallicon: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVS_SMALLICON"
		end

	Lvs_sortascending: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVS_SORTASCENDING"
		end

	Lvs_sortdescending: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVS_SORTDESCENDING"
		end

end -- class WEL_LVS_CONSTANTS

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
