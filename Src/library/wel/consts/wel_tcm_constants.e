indexing
	description: "Tab control message (TCM) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TCM_CONSTANTS

feature -- Access

	Tcm_adjustrect: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TCM_ADJUSTRECT"
		end

	Tcm_deleteallitems: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TCM_DELETEALLITEMS"
		end

	Tcm_deleteitem: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TCM_DELETEITEM"
		end

	Tcm_getcurfocus: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TCM_GETCURFOCUS"
		end

	Tcm_getcursel: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TCM_GETCURSEL"
		end

	Tcm_getimagelist: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TCM_GETIMAGELIST"
		end

	Tcm_getitem: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TCM_GETITEM"
		end

	Tcm_getitemcount: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TCM_GETITEMCOUNT"
		end

	Tcm_getitemrect: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TCM_GETITEMRECT"
		end

	Tcm_getrowcount: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TCM_GETROWCOUNT"
		end

	Tcm_gettooltips: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TCM_GETTOOLTIPS"
		end

	Tcm_hittest: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TCM_HITTEST"
		end

	Tcm_insertitem: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TCM_INSERTITEM"
		end

	Tcm_removeimage: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TCM_REMOVEIMAGE"
		end

	Tcm_setcursel: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TCM_SETCURSEL"
		end

	Tcm_setimagelist: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TCM_SETIMAGELIST"
		end

	Tcm_setitem: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TCM_SETITEM"
		end

	Tcm_setitemextra: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TCM_SETITEMEXTRA"
		end

	Tcm_setitemsize: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TCM_SETITEMSIZE"
		end

	Tcm_setpadding: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TCM_SETPADDING"
		end

	Tcm_settooltips: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TCM_SETTOOLTIPS"
		end

	Tcm_highlightitem: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TCM_HIGHLIGHTITEM"
		end

end -- class WEL_TCM_CONSTANTS

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

