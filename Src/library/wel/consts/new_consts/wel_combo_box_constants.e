indexing
	description	: "ComboBox Windows Constants."
	status		: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_COMBO_BOX_CONSTANTS

feature -- Style

	Cbs_autohscroll: INTEGER is 64
			-- Automatically scrolls the text in an edit control to the right
			-- when the user types a character at the end of the line. If
			-- this style is not set, only text that fits within the
			-- rectangular boundary is allowed. 
			--
			-- Declared in Windows as CBS_AUTOHSCROLL

	Cbs_simple: INTEGER is 1
			-- Displays the list box at all times. The current selection in
			-- the list box is displayed in the edit control. 
			--
			-- Declared in Windows as CBS_SIMPLE

	Cbs_dropdown: INTEGER is 2
			-- Similar to CBS_SIMPLE, except that the list box is not
			-- displayed unless the user selects an icon next to the edit
			-- control. 
			--
			-- Declared in Windows as CBS_DROPDOWN

	Cbs_dropdownlist: INTEGER is 3
			-- Similar to CBS_DROPDOWN, except that the edit control is
			-- replaced by a static text item that displays the current
			-- selection in the list box. 
			--
			-- Declared in Windows as CBS_DROPDOWNLIST

	Cbs_ownerdrawfixed: INTEGER is 16
			-- Specifies that the owner of the list box is responsible for
			-- drawing its contents and that the items in the list box are
			-- all the same height. The owner window receives a
			-- WM_MEASUREITEM message when the combo box is created and a
			-- WM_DRAWITEM message when a visual aspect of the combo box has
			-- changed. 
			--
			-- Declared in Windows as CBS_OWNERDRAWFIXED

	Cbs_ownerdrawvariable: INTEGER is 32
			-- Specifies that the owner of the list box is responsible for
			-- drawing its contents and that the items in the list box are
			-- variable in height. The owner window receives a WM_MEASUREITEM
			-- message for each item in the combo box when you create the
			-- combo box and a WM_DRAWITEM message when a visual aspect of
			-- the combo box has changed. 
			--
			-- Declared in Windows as CBS_OWNERDRAWVARIABLE

	Cbs_oemconvert: INTEGER is 128
			-- Converts text entered in the combo box edit control from the
			-- Windows character set to the OEM character set and then back
			-- to the Windows set. This ensures proper character conversion
			-- when the application calls the CharToOem function to convert a
			-- Windows string in the combo box to OEM characters. This style
			-- is most useful for combo boxes that contain file names and
			-- applies only to combo boxes created with the CBS_SIMPLE or
			-- CBS_DROPDOWN style. 
			--
			-- Declared in Windows as CBS_OEMCONVERT

	Cbs_sort: INTEGER is 256
			-- Automatically sorts strings added to the list box. 
			-- Declared in Windows as CBS_SORT

	Cbs_hasstrings: INTEGER is 512
			-- Specifies that an owner-drawn combo box contains items
			-- consisting of strings. The combo box maintains the memory and
			-- address for the strings so the application can use the
			-- CB_GETLBTEXT message to retrieve the text for a particular
			-- item. 
			--
			-- Declared in Windows as CBS_HASSTRINGS

	Cbs_disablenoscroll: INTEGER is 2048
			-- Shows a disabled vertical scroll bar in the list box when the
			-- box does not contain enough items to scroll. Without this
			-- style, the scroll bar is hidden when the list box does not
			-- contain enough items. 
			-- Declared in Windows as CBS_DISABLENOSCROLL

	Cbs_lowercase: INTEGER is 16384
			-- Converts to lowercase all text in both the selection field 
			-- and the list.
			--
			-- Declared in Windows as CBS_LOWERCASE

	Cbs_nointegralheight: INTEGER is 1024
			-- Specifies that the size of the combo box is exactly the size
			-- specified by the application when it created the combo box.
			-- Normally, the system sizes a combo box so that it does not
			-- display partial items. 
			--
			-- Declared in Windows as CBS_NOINTEGRALHEIGHT

	Cbs_uppercase: INTEGER is 8192
			-- Converts to uppercase all text in both the selection field and
			-- the list. 
			--
			-- Declared in Windows as CBS_UPPERCASE

feature -- Extended Style

	Cbes_ex_noeditimage: INTEGER is 1
			-- The edit box will not display an item image.
			--
			-- Declared in Windows as CBES_EX_NOEDITIMAGE

	Cbes_ex_noeditimageindent: INTEGER is 2
			-- The edit box will not indend text to make room
			-- for an item image.
			--
			-- Declared in Windows as CBES_EX_NOEDITIMAGEINDENT

feature -- Messages

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

feature -- Extended Messages

	Cbem_insertitem: INTEGER is 1025
			-- Inserts a new item in a ComboBoxEx.
			--
			-- Declared in Windows as CBEM_INSERTITEM

	Cbem_setimagelist: INTEGER is 1026
			-- Sets an image list for a ComboBoxEx control.
			--
			-- Declared in Windows as CBEM_SETIMAGELIST

	Cbem_getimagelist: INTEGER is 1027
			-- Retrieves the handle to an image list assigned
			-- to a ComboBoxEx control.
			--
			-- Declared in Windows as CBEM_GETIMAGELIST

	Cbem_getitem: INTEGER is 1028
			-- Retrieves item information for a given ComboBoxEx item.
			--
			-- Declared in Windows as CBEM_GETITEM

	Cbem_setitem: INTEGER is 1029
			-- Sets the attributes for an item in a ComboBoxEx control.
			--
			-- Declared in Windows as CBEM_SETITEM

	Cbem_deleteitem: INTEGER is 324
			-- Removes an item from a ComboBoxEx control.
			--
			-- Declared in Windows as CBEM_DELETEITEM

	Cbem_getcombocontrol: INTEGER is 1030
			-- Retrieves the handle to the child combo box control.
			--
			-- Declared in Windows as CBEM_GETCOMBOCONTROL

	Cbem_geteditcontrol: INTEGER is 1031
			-- Retrieves the handke to the edit control portion of
			-- a ComboBoxEc control.
			--
			-- Declared in Windows as CBEM_GETEDITCONTROL

	Cbem_setexstyle: INTEGER is 1032
			-- Sets extended styles within a ComboBoxEx control.
			--
			-- Declared in Windows as CBEM_SETEXSTYLE

	Cbem_getexstyle: INTEGER is 1033
			-- Retrieves the extended styles of a ComboBoxEx control.
			--
			-- Declared in Windows as CBEM_GETEXSTYLE

	Cbem_haseditchanged: INTEGER is 1034
			-- Determines if the user has changed the contents of the
			-- ComboBoxEx edit control by typing.
			--
			-- Declared in Windows as CBEM_HASEDITCHANGED

feature -- Notifications

	Cbn_errspace: INTEGER is -1
			-- Declared in Windows as CBN_ERRSPACE

	Cbn_selchange: INTEGER is 1
			-- Declared in Windows as CBN_SELCHANGE

	Cbn_dblclk: INTEGER is 2
			-- Declared in Windows as CBN_DBLCLK

	Cbn_setfocus: INTEGER is 3
			-- Declared in Windows as CBN_SETFOCUS

	Cbn_killfocus: INTEGER is 4
			-- Declared in Windows as CBN_KILLFOCUS

	Cbn_editchange: INTEGER is 5
			-- Declared in Windows as CBN_EDITCHANGE

	Cbn_editupdate: INTEGER is 6
			-- Declared in Windows as CBN_EDITUPDATE

	Cbn_dropdown: INTEGER is 7
			-- Declared in Windows as CBN_DROPDOWN

	Cbn_closeup: INTEGER is 8
			-- Declared in Windows as CBN_CLOSEUP

	Cbn_selendok: INTEGER is 9
			-- Declared in Windows as CBN_SELENDOK

	Cbn_selendcancel: INTEGER is 10
			-- Declared in Windows as CBN_SELENDCANCEL

feature -- Extended Notifications

	Cben_getdispinfo: INTEGER is -800
			-- Sent to retrieve display information about a callback item. 
			--
			-- Declared in Windows as CBEN_GETDISPINFO

	Cben_insertitem: INTEGER is -801
			-- Send when a new item has been inserted in the control.
			--
			-- Declared in Windows as CBEN_INSERTITEM

	Cben_deleteitem: INTEGER is -802
			-- Sent when an item has been deleted.
			--
			-- Declared in Windows as CBEN_DELETEITEM

	Cben_beginedit: INTEGER is -804
			-- Sent when the user activates the drop-down list in the
			-- control's edit box.
			--
			-- Declared in Windows as CBEN_BEGINEDIT

	Cben_endedit: INTEGER is -805
			-- Sent when the user has concluded an operation within
			-- the edit box or has selected an item from the control's
			-- drop-down list.
			--
			-- Declared in Windows as CBEN_ENDEDIT

feature -- Extended Notification Flags

	Cbenf_dropdown: INTEGER is 4
			-- The user activated the drop-down list.
			--
			-- Declared in Windows as CBENF_DROPDOWN

	Cbenf_escape: INTEGER is 3
			-- The user pressed the ESCAPE key.
			--
			-- Declared in Windows as CBENF_ESCAPE

	Cbenf_killfocus: INTEGER is 1
			-- The edit box lost the keyboard focus.
			--
			-- Declared in Windows as CBENF_KILLFOCUS

	Cbenf_return: INTEGER is 2
			-- The user completed the edit operation by pressing
			-- the ENTER key.
			--
			-- Declared in Windows as CBENF_RETURN

feature -- Structure Information

	Cbeif_text: INTEGER is 1
			-- The `text' member is valid or must be filled in.
			--
			-- Declared in Windows as CBEIF_TEXT

	Cbeif_image: INTEGER is 2
			-- The `image' member is valid or must be filled in.
			--
			-- Declared in Windows as CBEIF_IMAGE

	Cbeif_selectedimage: INTEGER is 4
			-- The `selected_image' member is valid or must be
			-- filled in.
			--
			-- Declared in Windows as CBEIF_SELECTEDIMAGE

	Cbeif_overlay: INTEGER is 8
			-- The `overlay' member is valid or must be filled in.
			--
			-- Declared in Windows as CBEIF_OVERLAY

	Cbeif_indent: INTEGER is 16
			-- The `indent' member is valid or must be filled in.
			--
			-- Declared in Windows as CBEIF_INDENT

	Cbeif_di_setitem: INTEGER is 268435456
			-- The control should store the item data and not ask
			-- for it again. This flag is used only with the
			-- CBEN_GETDISPINFO notification message.
			--
			-- Declared in Windows as CBEIF_DI_SETITEM

	Cbeif_lparam: INTEGER is 32
			-- The `lparam' member is valid or must be filled in.
			--
			-- Declared in Windows as CBEIF_LPARAM

end -- class WEL_COMBO_BOX_CONSTANTS


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

