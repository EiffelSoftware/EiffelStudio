note
	description: "ComboBox message (CB) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CB_CONSTANTS

obsolete
	"Use WEL_COMBO_BOX_CONSTANTS instead."

feature -- Access

	Cb_geteditsel: INTEGER = 320
			-- Declared in Windows as CB_GETEDITSEL

	Cb_limittext: INTEGER = 321
			-- Declared in Windows as CB_LIMITTEXT

	Cb_seteditsel: INTEGER = 322
			-- Declared in Windows as CB_SETEDITSEL

	Cb_addstring: INTEGER = 323
			-- Declared in Windows as CB_ADDSTRING

	Cb_deletestring: INTEGER = 324
			-- Declared in Windows as CB_DELETESTRING

	Cb_dir: INTEGER = 325
			-- Declared in Windows as CB_DIR

	Cb_getcount: INTEGER = 326
			-- Declared in Windows as CB_GETCOUNT

	Cb_getcursel: INTEGER = 327
			-- Declared in Windows as CB_GETCURSEL

	Cb_getlbtext: INTEGER = 328
			-- Declared in Windows as CB_GETLBTEXT

	Cb_getlbtextlen: INTEGER = 329
			-- Declared in Windows as CB_GETLBTEXTLEN

	Cb_insertstring: INTEGER = 330
			-- Declared in Windows as CB_INSERTSTRING

	Cb_resetcontent: INTEGER = 331
			-- Declared in Windows as CB_RESETCONTENT

	Cb_findstring: INTEGER = 332
			-- Declared in Windows as CB_FINDSTRING

	Cb_selectstring: INTEGER = 333
			-- Declared in Windows as CB_SELECTSTRING

	Cb_setcursel: INTEGER = 334
			-- Declared in Windows as CB_SETCURSEL

	Cb_showdropdown: INTEGER = 335
			-- Declared in Windows as CB_SHOWDROPDOWN

	Cb_getitemdata: INTEGER = 336
			-- Declared in Windows as CB_GETITEMDATA

	Cb_setitemdata: INTEGER = 337
			-- Declared in Windows as CB_SETITEMDATA

	Cb_getdroppedcontrolrect: INTEGER = 338
			-- Declared in Windows as CB_GETDROPPEDCONTROLRECT

	Cb_setitemheight: INTEGER = 339
			-- Declared in Windows as CB_SETITEMHEIGHT

	Cb_getitemheight: INTEGER = 340
			-- Declared in Windows as CB_GETITEMHEIGHT

	Cb_setextendedui: INTEGER = 341
			-- Declared in Windows as CB_SETEXTENDEDUI

	Cb_getextendedui: INTEGER = 342
			-- Declared in Windows as CB_GETEXTENDEDUI

	Cb_getdroppedstate: INTEGER = 343
			-- Declared in Windows as CB_GETDROPPEDSTATE

	Cb_findstringexact: INTEGER = 344
			-- Declared in Windows as CB_FINDSTRINGEXACT

	Cb_okay: INTEGER = 0
			-- Declared in Windows as CB_OKAY

	Cb_err: INTEGER = -1
			-- Declared in Windows as CB_ERR

	Cb_errspace: INTEGER = -2
			-- Declared in Windows as CB_ERRSPACE

	Cb_gettopindex: INTEGER = 347
			-- An application sends the CB_GETTOPINDEX message to
			-- retrieve the zero-based index of the first visible
			-- item in the list box portion of a combo box.
			--
			-- Initially, the item with index 0 is at the top of
			-- the list box, but if the list box contents have
			-- been scrolled, another item may be at the top.

	Cb_settopindex: INTEGER = 348;
			-- An application sends the CB_SETTOPINDEX message to
			-- ensure that a particular item is visible in the
			-- list box of a combo box. The system scrolls the
			-- list box contents so that either the specified
			-- item appears at the top of the list box or the
			-- maximum scroll range has been reached.

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_CB_CONSTANTS

