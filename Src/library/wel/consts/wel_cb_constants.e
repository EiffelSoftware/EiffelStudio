indexing
	description	: "ComboBox message (CB) constants."
	status		: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_CB_CONSTANTS

feature -- Access

	Cb_geteditsel: INTEGER is 320
			-- Declared in Windows as CB_GETEDITSEL

	Cb_limittext: INTEGER is 321
			-- Declared in Windows as CB_LIMITTEXT

	Cb_seteditsel: INTEGER is 322
			-- Declared in Windows as CB_SETEDITSEL

	Cb_addstring: INTEGER is 323
			-- Declared in Windows as CB_ADDSTRING

	Cb_deletestring: INTEGER is 324
			-- Declared in Windows as CB_DELETESTRING

	Cb_dir: INTEGER is 325
			-- Declared in Windows as CB_DIR

	Cb_getcount: INTEGER is 326
			-- Declared in Windows as CB_GETCOUNT

	Cb_getcursel: INTEGER is 327
			-- Declared in Windows as CB_GETCURSEL

	Cb_getlbtext: INTEGER is 328
			-- Declared in Windows as CB_GETLBTEXT

	Cb_getlbtextlen: INTEGER is 329
			-- Declared in Windows as CB_GETLBTEXTLEN

	Cb_insertstring: INTEGER is 330
			-- Declared in Windows as CB_INSERTSTRING

	Cb_resetcontent: INTEGER is 331
			-- Declared in Windows as CB_RESETCONTENT

	Cb_findstring: INTEGER is 332
			-- Declared in Windows as CB_FINDSTRING

	Cb_selectstring: INTEGER is 333
			-- Declared in Windows as CB_SELECTSTRING

	Cb_setcursel: INTEGER is 334
			-- Declared in Windows as CB_SETCURSEL

	Cb_showdropdown: INTEGER is 335
			-- Declared in Windows as CB_SHOWDROPDOWN

	Cb_getitemdata: INTEGER is 336
			-- Declared in Windows as CB_GETITEMDATA

	Cb_setitemdata: INTEGER is 337
			-- Declared in Windows as CB_SETITEMDATA

	Cb_getdroppedcontrolrect: INTEGER is 338
			-- Declared in Windows as CB_GETDROPPEDCONTROLRECT

	Cb_setitemheight: INTEGER is 339
			-- Declared in Windows as CB_SETITEMHEIGHT

	Cb_getitemheight: INTEGER is 340
			-- Declared in Windows as CB_GETITEMHEIGHT

	Cb_setextendedui: INTEGER is 341
			-- Declared in Windows as CB_SETEXTENDEDUI

	Cb_getextendedui: INTEGER is 342
			-- Declared in Windows as CB_GETEXTENDEDUI

	Cb_getdroppedstate: INTEGER is 343
			-- Declared in Windows as CB_GETDROPPEDSTATE

	Cb_findstringexact: INTEGER is 344
			-- Declared in Windows as CB_FINDSTRINGEXACT

	Cb_okay: INTEGER is 0
			-- Declared in Windows as CB_OKAY

	Cb_err: INTEGER is -1
			-- Declared in Windows as CB_ERR

	Cb_errspace: INTEGER is -2
			-- Declared in Windows as CB_ERRSPACE

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

