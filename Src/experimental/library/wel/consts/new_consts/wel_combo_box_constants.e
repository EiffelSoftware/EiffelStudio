note
	description: "ComboBox Windows Constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_COMBO_BOX_CONSTANTS

feature -- Style

	Cbs_autohscroll: INTEGER = 64
			-- Automatically scrolls the text in an edit control to the right
			-- when the user types a character at the end of the line. If
			-- this style is not set, only text that fits within the
			-- rectangular boundary is allowed.
			--
			-- Declared in Windows as CBS_AUTOHSCROLL

	Cbs_simple: INTEGER = 1
			-- Displays the list box at all times. The current selection in
			-- the list box is displayed in the edit control.
			--
			-- Declared in Windows as CBS_SIMPLE

	Cbs_dropdown: INTEGER = 2
			-- Similar to CBS_SIMPLE, except that the list box is not
			-- displayed unless the user selects an icon next to the edit
			-- control.
			--
			-- Declared in Windows as CBS_DROPDOWN

	Cbs_dropdownlist: INTEGER = 3
			-- Similar to CBS_DROPDOWN, except that the edit control is
			-- replaced by a static text item that displays the current
			-- selection in the list box.
			--
			-- Declared in Windows as CBS_DROPDOWNLIST

	Cbs_ownerdrawfixed: INTEGER = 16
			-- Specifies that the owner of the list box is responsible for
			-- drawing its contents and that the items in the list box are
			-- all the same height. The owner window receives a
			-- WM_MEASUREITEM message when the combo box is created and a
			-- WM_DRAWITEM message when a visual aspect of the combo box has
			-- changed.
			--
			-- Declared in Windows as CBS_OWNERDRAWFIXED

	Cbs_ownerdrawvariable: INTEGER = 32
			-- Specifies that the owner of the list box is responsible for
			-- drawing its contents and that the items in the list box are
			-- variable in height. The owner window receives a WM_MEASUREITEM
			-- message for each item in the combo box when you create the
			-- combo box and a WM_DRAWITEM message when a visual aspect of
			-- the combo box has changed.
			--
			-- Declared in Windows as CBS_OWNERDRAWVARIABLE

	Cbs_oemconvert: INTEGER = 128
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

	Cbs_sort: INTEGER = 256
			-- Automatically sorts strings added to the list box.
			-- Declared in Windows as CBS_SORT

	Cbs_hasstrings: INTEGER = 512
			-- Specifies that an owner-drawn combo box contains items
			-- consisting of strings. The combo box maintains the memory and
			-- address for the strings so the application can use the
			-- CB_GETLBTEXT message to retrieve the text for a particular
			-- item.
			--
			-- Declared in Windows as CBS_HASSTRINGS

	Cbs_disablenoscroll: INTEGER = 2048
			-- Shows a disabled vertical scroll bar in the list box when the
			-- box does not contain enough items to scroll. Without this
			-- style, the scroll bar is hidden when the list box does not
			-- contain enough items.
			-- Declared in Windows as CBS_DISABLENOSCROLL

	Cbs_lowercase: INTEGER = 16384
			-- Converts to lowercase all text in both the selection field
			-- and the list.
			--
			-- Declared in Windows as CBS_LOWERCASE

	Cbs_nointegralheight: INTEGER = 1024
			-- Specifies that the size of the combo box is exactly the size
			-- specified by the application when it created the combo box.
			-- Normally, the system sizes a combo box so that it does not
			-- display partial items.
			--
			-- Declared in Windows as CBS_NOINTEGRALHEIGHT

	Cbs_uppercase: INTEGER = 8192
			-- Converts to uppercase all text in both the selection field and
			-- the list.
			--
			-- Declared in Windows as CBS_UPPERCASE

feature -- Extended Style

	Cbes_ex_noeditimage: INTEGER = 1
			-- The edit box will not display an item image.
			--
			-- Declared in Windows as CBES_EX_NOEDITIMAGE

	Cbes_ex_noeditimageindent: INTEGER = 2
			-- The edit box will not indend text to make room
			-- for an item image.
			--
			-- Declared in Windows as CBES_EX_NOEDITIMAGEINDENT

feature -- Messages

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

	Cb_getdroppedwidth: INTEGER = 0x015f
			-- An application sends the CB_GETDROPPEDWIDTH message to
			-- retrieve the minimum allowable width, in pixels, of the
			-- list box of a combo box with the CBS_DROPDOWN or CBS_DROPDOWNLIST style.

	Cb_setdroppedwidth: INTEGER = 0x0160
			-- An application sends the CB_SETDROPPEDWIDTH message to set
			-- the maximum allowable width, in pixels, of the list box of
			-- a combo box with the CBS_DROPDOWN or CBS_DROPDOWNLIST style. 

	Cb_gethorizontalextent: INTEGER = 0x015d
			-- An application sends the CB_GETHORIZONTALEXTENT message to
			-- retrieve from a combo box the width, in pixels, by which
			-- the list box can be scrolled horizontally (the scrollable width).
			-- This is applicable only if the list box has a horizontal scroll bar.

	Cb_sethorizontalextent: INTEGER = 0x015e
			-- An application sends the CB_SETHORIZONTALEXTENT message to
			-- set the width, in pixels, by which a list box can be scrolled
			-- horizontally (the scrollable width). If the width of the list
			-- box is smaller than this value, the horizontal scroll bar
			-- horizontally scrolls items in the list box. If the width
			-- of the list box is equal to or greater than this value,
			-- the horizontal scroll bar is hidden or, if the combo box has
			-- the CBS_DISABLENOSCROLL style, disabled.

feature -- Extended Messages

	Cbem_insertitem: INTEGER = 1035
			-- Inserts a new item in a ComboBoxEx.
			--
			-- Declared in Windows as CBEM_INSERTITEM

	Cbem_setimagelist: INTEGER = 1026
			-- Sets an image list for a ComboBoxEx control.
			--
			-- Declared in Windows as CBEM_SETIMAGELIST

	Cbem_getimagelist: INTEGER = 1027
			-- Retrieves the handle to an image list assigned
			-- to a ComboBoxEx control.
			--
			-- Declared in Windows as CBEM_GETIMAGELIST

	Cbem_getitem: INTEGER = 1037
			-- Retrieves item information for a given ComboBoxEx item.
			--
			-- Declared in Windows as CBEM_GETITEM

	Cbem_setitem: INTEGER = 1036
			-- Sets the attributes for an item in a ComboBoxEx control.
			--
			-- Declared in Windows as CBEM_SETITEM

	Cbem_deleteitem: INTEGER = 324
			-- Removes an item from a ComboBoxEx control.
			--
			-- Declared in Windows as CBEM_DELETEITEM

	Cbem_getcombocontrol: INTEGER = 1030
			-- Retrieves the handle to the child combo box control.
			--
			-- Declared in Windows as CBEM_GETCOMBOCONTROL

	Cbem_geteditcontrol: INTEGER = 1031
			-- Retrieves the handke to the edit control portion of
			-- a ComboBoxEc control.
			--
			-- Declared in Windows as CBEM_GETEDITCONTROL

	Cbem_setexstyle: INTEGER = 1032
			-- Sets extended styles within a ComboBoxEx control.
			--
			-- Declared in Windows as CBEM_SETEXSTYLE

	Cbem_getexstyle: INTEGER = 1033
			-- Retrieves the extended styles of a ComboBoxEx control.
			--
			-- Declared in Windows as CBEM_GETEXSTYLE

	Cbem_haseditchanged: INTEGER = 1034;
			-- Determines if the user has changed the contents of the
			-- ComboBoxEx edit control by typing.
			--
			-- Declared in Windows as CBEM_HASEDITCHANGED

feature -- Notifications

	Cbn_errspace: INTEGER = -1
			-- Declared in Windows as CBN_ERRSPACE

	Cbn_selchange: INTEGER = 1
			-- Declared in Windows as CBN_SELCHANGE

	Cbn_dblclk: INTEGER = 2
			-- Declared in Windows as CBN_DBLCLK

	Cbn_setfocus: INTEGER = 3
			-- Declared in Windows as CBN_SETFOCUS

	Cbn_killfocus: INTEGER = 4
			-- Declared in Windows as CBN_KILLFOCUS

	Cbn_editchange: INTEGER = 5
			-- Declared in Windows as CBN_EDITCHANGE

	Cbn_editupdate: INTEGER = 6
			-- Declared in Windows as CBN_EDITUPDATE

	Cbn_dropdown: INTEGER = 7
			-- Declared in Windows as CBN_DROPDOWN

	Cbn_closeup: INTEGER = 8
			-- Declared in Windows as CBN_CLOSEUP

	Cbn_selendok: INTEGER = 9
			-- Declared in Windows as CBN_SELENDOK

	Cbn_selendcancel: INTEGER = 10
			-- Declared in Windows as CBN_SELENDCANCEL

feature -- Extended Notifications

	Cben_getdispinfo: INTEGER = -807
			-- Sent to retrieve display information about a callback item.
			--
			-- Declared in Windows as CBEN_GETDISPINFO

	Cben_insertitem: INTEGER = -801
			-- Send when a new item has been inserted in the control.
			--
			-- Declared in Windows as CBEN_INSERTITEM

	Cben_deleteitem: INTEGER = -802
			-- Sent when an item has been deleted.
			--
			-- Declared in Windows as CBEN_DELETEITEM

	Cben_beginedit: INTEGER = -804
			-- Sent when the user activates the drop-down list in the
			-- control's edit box.
			--
			-- Declared in Windows as CBEN_BEGINEDIT

	Cben_endedit: INTEGER = -806
			-- Sent when the user has concluded an operation within
			-- the edit box or has selected an item from the control's
			-- drop-down list.
			--
			-- Declared in Windows as CBEN_ENDEDIT

feature -- Access : notification flags

	Cbenf_dropdown: INTEGER = 4
			-- The user activated the drop-down list.
			--
			-- Declared in Windows as CBENF_DROPDOWN

	Cbenf_escape: INTEGER = 3
			-- The user pressed the ESCAPE key.
			--
			-- Declared in Windows as CBENF_ESCAPE

	Cbenf_killfocus: INTEGER = 1
			-- The edit box lost the keyboard focus.
			--
			-- Declared in Windows as CBENF_KILLFOCUS

	Cbenf_return: INTEGER = 2;
			-- The user completed the edit operation by pressing
			-- the ENTER key.
			--
			-- Declared in Windows as CBENF_RETURN

feature -- Structure Information

	Cbeif_text: INTEGER = 1
			-- The `text' member is valid or must be filled in.
			--
			-- Declared in Windows as CBEIF_TEXT

	Cbeif_image: INTEGER = 2
			-- The `image' member is valid or must be filled in.
			--
			-- Declared in Windows as CBEIF_IMAGE

	Cbeif_selectedimage: INTEGER = 4
			-- The `selected_image' member is valid or must be
			-- filled in.
			--
			-- Declared in Windows as CBEIF_SELECTEDIMAGE

	Cbeif_overlay: INTEGER = 8
			-- The `overlay' member is valid or must be filled in.
			--
			-- Declared in Windows as CBEIF_OVERLAY

	Cbeif_indent: INTEGER = 16
			-- The `indent' member is valid or must be filled in.
			--
			-- Declared in Windows as CBEIF_INDENT

	Cbeif_di_setitem: INTEGER = 268435456
			-- The control should store the item data and not ask
			-- for it again. This flag is used only with the
			-- CBEN_GETDISPINFO notification message.
			--
			-- Declared in Windows as CBEIF_DI_SETITEM

	Cbeif_lparam: INTEGER = 32;
			-- The `lparam' member is valid or must be filled in.
			--
			-- Declared in Windows as CBEIF_LPARAM

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




end -- class WEL_COMBO_BOX_CONSTANTS

