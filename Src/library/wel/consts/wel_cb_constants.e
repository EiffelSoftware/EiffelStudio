indexing
	description: "ComboBox message (CB) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CB_CONSTANTS

feature -- Access

	Cb_geteditsel: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"CB_GETEDITSEL"
		end

	Cb_limittext: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"CB_LIMITTEXT"
		end

	Cb_seteditsel: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"CB_SETEDITSEL"
		end

	Cb_addstring: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"CB_ADDSTRING"
		end

	Cb_deletestring: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"CB_DELETESTRING"
		end

	Cb_dir: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"CB_DIR"
		end

	Cb_getcount: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"CB_GETCOUNT"
		end

	Cb_getcursel: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"CB_GETCURSEL"
		end

	Cb_getlbtext: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"CB_GETLBTEXT"
		end

	Cb_getlbtextlen: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"CB_GETLBTEXTLEN"
		end

	Cb_insertstring: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"CB_INSERTSTRING"
		end

	Cb_resetcontent: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"CB_RESETCONTENT"
		end

	Cb_findstring: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"CB_FINDSTRING"
		end

	Cb_selectstring: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"CB_SELECTSTRING"
		end

	Cb_setcursel: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"CB_SETCURSEL"
		end

	Cb_showdropdown: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"CB_SHOWDROPDOWN"
		end

	Cb_getitemdata: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"CB_GETITEMDATA"
		end

	Cb_setitemdata: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"CB_SETITEMDATA"
		end

	Cb_getdroppedcontrolrect: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"CB_GETDROPPEDCONTROLRECT"
		end

	Cb_setitemheight: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"CB_SETITEMHEIGHT"
		end

	Cb_getitemheight: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"CB_GETITEMHEIGHT"
		end

	Cb_setextendedui: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"CB_SETEXTENDEDUI"
		end

	Cb_getextendedui: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"CB_GETEXTENDEDUI"
		end

	Cb_getdroppedstate: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"CB_GETDROPPEDSTATE"
		end

	Cb_findstringexact: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"CB_FINDSTRINGEXACT"
		end

	Cb_okay: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"CB_OKAY"
		end

	Cb_err: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"CB_ERR"
		end

	Cb_errspace: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"CB_ERRSPACE"
		end

	Cb_gettopindex: INTEGER is 347
			-- An application sends the CB_GETTOPINDEX message to 
			-- retrieve the zero-based index of the first visible 
			-- item in the list box portion of a combo box. 
			--
			-- Initially, the item with index 0 is at the top of 
			-- the list box, but if the list box contents have 
			-- been scrolled, another item may be at the top. 

	Cb_settopindex: INTEGER is 348
			-- An application sends the CB_SETTOPINDEX message to 
			-- ensure that a particular item is visible in the 
			-- list box of a combo box. The system scrolls the 
			-- list box contents so that either the specified 
			-- item appears at the top of the list box or the 
			-- maximum scroll range has been reached.

end -- class WEL_CB_CONSTANTS

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

