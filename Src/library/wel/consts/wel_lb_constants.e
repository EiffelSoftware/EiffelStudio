indexing
	description: "ListBox message (LB) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_LB_CONSTANTS

feature -- Access

	Lb_addstring: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"LB_ADDSTRING"
		end

	Lb_insertstring: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"LB_INSERTSTRING"
		end

	Lb_deletestring: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"LB_DELETESTRING"
		end

	Lb_resetcontent: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"LB_RESETCONTENT"
		end

	Lb_setsel: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"LB_SETSEL"
		end

	Lb_setcursel: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"LB_SETCURSEL"
		end

	Lb_getsel: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"LB_GETSEL"
		end

	Lb_getcursel: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"LB_GETCURSEL"
		end

	Lb_gettext: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"LB_GETTEXT"
		end

	Lb_gettextlen: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"LB_GETTEXTLEN"
		end

	Lb_getcount: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"LB_GETCOUNT"
		end

	Lb_selectstring: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"LB_SELECTSTRING"
		end

	Lb_dir: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"LB_DIR"
		end

	Lb_gettopindex: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"LB_GETTOPINDEX"
		end

	Lb_findstring: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"LB_FINDSTRING"
		end

	Lb_getselcount: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"LB_GETSELCOUNT"
		end

	Lb_getselitems: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"LB_GETSELITEMS"
		end

	Lb_settabstops: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"LB_SETTABSTOPS"
		end

	Lb_gethorizontalextent: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"LB_GETHORIZONTALEXTENT"
		end

	Lb_sethorizontalextent: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"LB_SETHORIZONTALEXTENT"
		end

	Lb_setcolumnwidth: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"LB_SETCOLUMNWIDTH"
		end

	Lb_settopindex: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"LB_SETTOPINDEX"
		end

	Lb_getitemrect: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"LB_GETITEMRECT"
		end

	Lb_getitemdata: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"LB_GETITEMDATA"
		end

	Lb_setitemdata: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"LB_SETITEMDATA"
		end

	Lb_selitemrange: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"LB_SELITEMRANGE"
		end

	Lb_setcaretindex: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"LB_SETCARETINDEX"
		end

	Lb_getcaretindex: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"LB_GETCARETINDEX"
		end

	Lb_setitemheight: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"LB_SETITEMHEIGHT"
		end

	Lb_getitemheight: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"LB_GETITEMHEIGHT"
		end

	Lb_findstringexact: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"LB_FINDSTRINGEXACT"
		end

	Lb_okay: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"LB_OKAY"
		end

	Lb_err: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"LB_ERR"
		end

	Lb_errspace: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"LB_ERRSPACE"
		end

	Lb_ctlcode: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"LB_CTLCODE"
		end

end -- class WEL_LB_CONSTANTS

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

