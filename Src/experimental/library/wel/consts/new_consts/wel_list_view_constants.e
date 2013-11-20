note
	description: "ListView Control Constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_LIST_VIEW_CONSTANTS

feature -- Style

	Lvs_icon: INTEGER = 0
			-- This style specifies icon view.
			--
			-- Declared in Windows as LVS_ICON

	Lvs_report: INTEGER = 1
			-- This style specifies report view. When using the LVS_REPORT
			-- style with a list view control, the first column is always
			-- left-aligned. You cannot use LVCFMT_RIGHT to change this
			-- alignment. See LVCOLUMN for further information on column
			-- alignment.
			--
			-- Declared in Windows as LVS_REPORT

	Lvs_smallicon: INTEGER = 2
			-- This style specifies small icon view.
			--
			-- Declared in Windows as LVS_SMALLICON

	Lvs_list: INTEGER = 3
			-- This style specifies list view.
			--
			-- Declared in Windows as LVS_LIST

	Lvs_alignleft: INTEGER = 2048
			-- Items are left-aligned in icon and small icon view.
			--
			-- Declared in Windows as LVS_ALIGNLEFT

	Lvs_aligntop: INTEGER = 0
			-- Items are aligned with the top of the list view control in
			-- icon and small icon view.
			--
			-- Declared in Windows as LVS_ALIGNTOP

	Lvs_autoarrange: INTEGER = 256
			-- Icons are automatically kept arranged in icon and small icon
			-- view.
			--
			-- Declared in Windows as LVS_AUTOARRANGE

	Lvs_editlabels: INTEGER = 512
			-- Item text can be edited in place. The parent window must
			-- process the LVN_ENDLABELEDIT notification message.
			--
			-- Declared in Windows as LVS_EDITLABELS

	Lvs_nocolumnheader: INTEGER = 16384
			-- Declared in Windows as LVS_NOCOLUMNHEADER

	Lvs_nosortheader: INTEGER = 32768
			-- Column headers do not work like buttons. This style can be
			-- used if clicking a column header in report view does not
			-- carry out an action, such as sorting.
			--
			-- Declared in Windows as LVS_NOSORTHEADER

	Lvs_nolabelwrap: INTEGER = 128
			-- Item text is displayed on a single line in icon view. By
			-- default, item text may wrap in icon view.
			--
			-- Declared in Windows as LVS_NOLABELWRAP

	Lvs_noscroll: INTEGER = 8192
			-- Scrolling is disabled. All items must be within the client
			-- area. This style is not compatible with the LVS_LIST or
			-- LVS_REPORT styles.
			--
			-- Declared in Windows as LVS_NOSCROLL

	Lvs_ownerdrawfixed: INTEGER = 1024
			-- The owner window can paint items in report view. The list
			-- view control sends a WM_DRAWITEM message to paint each item;
			-- it does not send separate messages for each subitem. The
			-- itemData member of the DRAWITEMSTRUCT structure contains the
			-- item data for the specified list view item.
			--
			-- Declared in Windows as LVS_OWNERDRAWFIXED

	Lvs_shareimagelists: INTEGER = 64
			-- The image list will not be deleted when the control is
			-- destroyed. This style enables the use of the same image lists
			-- with multiple list view controls.
			--
			-- Declared in Windows as LVS_SHAREIMAGELISTS

	Lvs_showselalways: INTEGER = 8
			-- The selection, if any, is always shown, even if the control
			-- does not have the focus.
			--
			-- Declared in Windows as LVS_SHOWSELALWAYS

	Lvs_singlesel: INTEGER = 4
			-- Only one item at a time can be selected. By default, multiple
			-- items may be selected.
			--
			-- Declared in Windows as LVS_SINGLESEL

	Lvs_sortascending: INTEGER = 16
			-- Item indices are sorted based on item text in ascending
			-- order.
			--
			-- Declared in Windows as LVS_SORTASCENDING

	Lvs_sortdescending: INTEGER = 32
			-- Item indices are sorted based on item text in descending
			-- order.
			--
			-- Declared in Windows as LVS_SORTDESCENDING

feature -- Extended Style

	Lvs_ex_checkboxes: INTEGER = 4
			-- Version 4.70.
			-- Enables check boxes for items in a list view
			-- control. Effectively, when set to this style, the control
			-- will create and set a state image list using
			-- DrawFrameControl. Check boxes are visible and functional
			-- with all list view modes. You can obtain the state of the
			-- check box for a given item with ListView_GetCheckState. To
			-- set the check state, use ListView_SetCheckState.

	Lvs_ex_flatsb: INTEGER = 256
			-- Version 4.71.
			-- Enables flat scroll bars in the list view.
			-- If you need more control over the appearance of the list
			-- view's scroll bars, you should manipulate the list view's
			-- scroll bars directly using the Flat Scroll Bar APIs. If
			-- the system metrics change, you are responsible for adjusting
			-- the scrollbar metrics with FlatSB_SetScrollProp. See Flat
			-- Scroll Bars for further details.

	Lvs_ex_fullrowselect: INTEGER = 32
			-- Version 4.70.
			-- When an item is selected, the item and all its subitems are
			-- highlighted. This style is available only in conjunction
			-- with the LVS_REPORT style.

	Lvs_ex_gridlines: INTEGER = 1
			-- Version 4.70. Displays gridlines around items and subitems.
			-- This style is available only in conjunction with the LVS_REPORT
			-- style.

	Lvs_ex_headerdragdrop: INTEGER = 16
			-- Version 4.70. Enables drag-and-drop reordering of columns in
			-- a list view control. This style is only available to list
			-- view controls that use the LVS_REPORT style.

	Lvs_ex_infotip: INTEGER = 1024
			-- Version 4.71. When a list view control uses the
			-- LVS_EX_INFOTIP style, the LVN_GETINFOTIP notification message
			-- is sent to the parent window before displaying an item's
			-- tooltip.

	Lvs_ex_labeltip: INTEGER = 16384
			-- Version 5.80. If a partially hidden label in any list view
			-- mode lacks tooltip text, the list view control will unfold
			-- the label. If this style is not set, the list view control
			-- will unfold partly hidden labels only for the large icon mode.

	Lvs_ex_multiworkareas: INTEGER = 8192
			-- Version 4.71. If the list view control has the LVS_AUTOARRANGE
			-- style, the control will not autoarrange its icons until one or
			-- more work areas are defined (see LVM_SETWORKAREAS). To be
			-- effective, this style must be set before any work areas are
			-- defined and any items have been added to the control.

	Lvs_ex_oneclickactivate: INTEGER = 64
			-- Version 4.70. The list view control sends an LVN_ITEMACTIVATE
			-- notification message to the parent window when the user clicks
			-- an item. This style also enables hot tracking in the list view
			-- control. Hot tracking means that when the cursor moves over an
			-- item, it is highlighted but not selected. See the Remarks for a
			-- discussion of item activation.

	Lvs_ex_regional: INTEGER = 512
			-- Version 4.71. The list view will create a region that includes
			-- only the item icons and text and set its window region to that
			-- using SetWindowRgn. This will exclude any area that is not part
			-- of an item from the window region. This style is only available
			-- to list view controls that use the LVS_ICON style.

	Lvs_ex_subitemimages: INTEGER = 2
			-- Version 4.70. Allows images to be displayed for subitems.
			-- This style is available only in conjunction with the LVS_REPORT
			-- style.

	Lvs_ex_trackselect: INTEGER = 8
			-- Version 4.70. Enables hot-track selection in a list view
			-- control. Hot track selection means that an item is
			-- automatically selected when the cursor remains over the item
			-- for a certain period of time. The delay can be changed from
			-- the default system setting with a LVM_SETHOVERTIME message.
			-- This style applies to all styles of list view control. You
			-- can check whether or not hot-track selection is enabled by
			-- calling SystemParametersInfo.

	Lvs_ex_twoclickactivate: INTEGER = 128
			-- Version 4.70. The list view control sends an LVN_ITEMACTIVATE
			-- notification message to the parent window when the user
			-- double-clicks an item. This style also enables hot tracking
			-- in the list view control. Hot tracking means that when the
			-- cursor moves over an item, it is highlighted but not
			-- selected. See the Remarks for a discussion of item
			-- activation.

	Lvs_ex_underlinecold: INTEGER = 4096
			-- Version 4.71. Causes non-hot items that are activatable to be
			-- displayed with underlined text. This style requires that
			-- LVS_EX_TWOCLICKACTIVATE also be set. See the Remarks for a
			-- discussion of item activation.

	Lvs_ex_underlinehot: INTEGER = 2048
			-- Version 4.71. Causes hot items that are activatable to be
			-- displayed with underlined text. This style requires that
			-- LVS_EX_ONECLICKACTIVATE or LVS_EX_TWOCLICKACTIVATE also be
			-- set. See the Remarks for a discussion of item activation.

	Lvs_ex_doublebuffer: INTEGER = 0x10000
			-- Version 6.00. Uses double buffering for rendering items.

feature -- Messages

	Lvm_arrange: INTEGER = 4118
			-- Declared in Windows as LVM_ARRANGE

	Lvm_createdragimage: INTEGER = 4129
			-- Declared in Windows as LVM_CREATEDRAGIMAGE

	Lvm_deleteallitems: INTEGER = 4105
			-- Declared in Windows as LVM_DELETEALLITEMS

	Lvm_deletecolumn: INTEGER = 4124
			-- Declared in Windows as LVM_DELETECOLUMN

	Lvm_deleteitem: INTEGER = 4104
			-- Declared in Windows as LVM_DELETEITEM

	Lvm_editlabel: INTEGER = 4214
			-- Declared in Windows as LVM_EDITLABEL

	Lvm_ensurevisible: INTEGER = 4115
			-- Declared in Windows as LVM_ENSUREVISIBLE

	Lvm_finditem: INTEGER = 4179
			-- Declared in Windows as LVM_FINDITEM

	Lvm_getbkcolor: INTEGER = 4096
			-- Declared in Windows as LVM_GETBKCOLOR

	Lvm_getcallbackmask: INTEGER = 4106
			-- Declared in Windows as LVM_GETCALLBACKMASK

	Lvm_getcolumn: INTEGER = 4191
			-- Declared in Windows as LVM_GETCOLUMN

	Lvm_getcolumnwidth: INTEGER = 4125
			-- Declared in Windows as LVM_GETCOLUMNWIDTH

	Lvm_getcountperpage: INTEGER = 4136
			-- Declared in Windows as LVM_GETCOUNTPERPAGE

	Lvm_geteditcontrol: INTEGER = 4120
			-- Declared in Windows as LVM_GETEDITCONTROL

	Lvm_getimagelist: INTEGER = 4098
			-- Declared in Windows as LVM_GETIMAGELIST

	Lvm_getisearchstring: INTEGER = 4213
			-- Declared in Windows as LVM_GETISEARCHSTRING

	Lvm_getitem: INTEGER = 4171
			-- Declared in Windows as LVM_GETITEM

	Lvm_getitemcount: INTEGER = 4100
			-- Declared in Windows as LVM_GETITEMCOUNT

	Lvm_getitemposition: INTEGER = 4112
			-- Declared in Windows as LVM_GETITEMPOSITION

	Lvm_getitemrect: INTEGER = 4110
			-- Declared in Windows as LVM_GETITEMRECT

	Lvm_getitemspacing: INTEGER = 4147
			-- Declared in Windows as LVM_GETITEMSPACING

	Lvm_getitemstate: INTEGER = 4140
			-- Declared in Windows as LVM_GETITEMSTATE

	Lvm_getitemtext: INTEGER = 4211
			-- Declared in Windows as LVM_GETITEMTEXT

	Lvm_getnextitem: INTEGER = 4108
			-- Declared in Windows as LVM_GETNEXTITEM

	Lvm_getorigin: INTEGER = 4137
			-- Declared in Windows as LVM_GETORIGIN

	Lvm_getselectedcount: INTEGER = 4146
			-- Declared in Windows as LVM_GETSELECTEDCOUNT

	Lvm_getstringwidth: INTEGER = 4183
			-- Declared in Windows as LVM_GETSTRINGWIDTH

	Lvm_gettextbkcolor: INTEGER = 4133
			-- Declared in Windows as LVM_GETTEXTBKCOLOR

	Lvm_gettextcolor: INTEGER = 4131
			-- Declared in Windows as LVM_GETTEXTCOLOR

	Lvm_gettopindex: INTEGER = 4135
			-- Declared in Windows as LVM_GETTOPINDEX

	Lvm_getviewrect: INTEGER = 4130
			-- Declared in Windows as LVM_GETVIEWRECT

	Lvm_hittest: INTEGER = 4114
			-- Declared in Windows as LVM_HITTEST

	Lvm_insertcolumn: INTEGER = 4193
			-- Declared in Windows as LVM_INSERTCOLUMN

	Lvm_insertitem: INTEGER = 4173
			-- Declared in Windows as LVM_INSERTITEM

	Lvm_redrawitems: INTEGER = 4117
			-- Declared in Windows as LVM_REDRAWITEMS

	Lvm_scroll: INTEGER = 4116
			-- Declared in Windows as LVM_SCROLL

	Lvm_setbkcolor: INTEGER = 4097
			-- Declared in Windows as LVM_SETBKCOLOR

	Lvm_setcallbackmask: INTEGER = 4107
			-- Declared in Windows as LVM_SETCALLBACKMASK

	Lvm_setcolumn: INTEGER = 4192
			-- Declared in Windows as LVM_SETCOLUMN

	Lvm_setcolumnwidth: INTEGER = 4126
			-- Declared in Windows as LVM_SETCOLUMNWIDTH

	Lvm_setimagelist: INTEGER = 4099
			-- Declared in Windows as LVM_SETIMAGELIST

	Lvm_setitem: INTEGER = 4172
			-- Declared in Windows as LVM_SETITEM

	Lvm_setitemcount: INTEGER = 4143
			-- Declared in Windows as LVM_SETITEMCOUNT

	Lvm_setitemposition: INTEGER = 4111
			-- Declared in Windows as LVM_SETITEMPOSITION

	Lvm_setitemposition32: INTEGER = 4145
			-- Declared in Windows as LVM_SETITEMPOSITION32

	Lvm_setitemstate: INTEGER = 4139
			-- Declared in Windows as LVM_SETITEMSTATE

	Lvm_setitemtext: INTEGER = 4212
			-- Declared in Windows as LVM_SETITEMTEXT

	Lvm_settextbkcolor: INTEGER = 4134
			-- Declared in Windows as LVM_SETTEXTBKCOLOR

	Lvm_settextcolor: INTEGER = 4132
			-- Declared in Windows as LVM_SETTEXTCOLOR

	Lvm_settooltips: INTEGER = 4170
			-- Sets the tooltip control that the list view
			-- control will use to display tooltips. You can send this
			-- message explicitly or use the ListView_SetToolTips macro
			--
			-- Declared in Windows as LVM_SETTOOLTIPS

	Lvm_sortitems: INTEGER = 4144
			-- Declared in Windows as LVM_SORTITEMS

	Lvm_setunicodeformat: INTEGER = 8197
			-- Sets the UNICODE character format flag for the
			-- control. This message allows you to change the character set
			-- used by the control at run time rather than having to re
			-- create the control.
			--
			-- Declared in Windows as LVM_SETUNICODEFORMAT

	Lvm_update: INTEGER = 4138
			-- Declared in Windows as LVM_UPDATE

	Lvm_approximateviewrect: INTEGER = 4160
			-- Version 4.70. Calculates the approximate width and height
			-- required to display a given number of items.
			--
			-- Declared in Windows as LVM_APPROXIMATEVIEWRECT

	Lvm_getbkimage: INTEGER = 4165
			-- Version 4.71. Retrieves the background image in a list view
			-- control.
			--
			-- Declared in Windows as LVM_GETBKIMAGE

	Lvm_getcolumnorderarray: INTEGER = 4155
			-- Version 4.70. Retrieves the current left-to-right order of
			-- columns in a list view control.
			--
			-- Declared in Windows as LVM_GETCOLUMNORDERARRAY

	Lvm_getextendedlistviewstyle: INTEGER = 4151
			-- Version 4.70. Retrieves the extended styles that are
			-- currently in use for a given list view control.
			--
			-- Declared in Windows as LVM_GETEXTENDEDLISTVIEWSTYLE

	Lvm_setextendedlistviewstyle: INTEGER = 4150
			-- Version 4.70. Sets extended styles in list view controls.
			--
			-- Declared in Windows as LVM_SETEXTENDEDLISTVIEWSTYLE

	Lvm_getheader: INTEGER = 4127
			-- Version 4.70. Retrieves the handle to the header control used
			-- by the list view control.
			--
			-- Declared in Windows as LVM_GETHEADER

	Lvm_gethotcursor: INTEGER = 4159
			-- Version 4.70. Retrieves the HCURSOR value used when the
			-- pointer is over an item while hot tracking is enabled
			--
			-- Declared in Windows as LVM_GETHOTCURSOR

	Lvm_gethotitem: INTEGER = 4157
			-- Version 4.70. Retrieves the index of the hot item.
			--
			-- Declared in Windows as LVM_GETHOTITEM

	Lvm_gethovertime: INTEGER = 4168
			-- Version 4.71. Retrieves the amount of time that the mouse
			-- cursor must hover over an item before it is selected.
			--
			-- Declared in Windows as LVM_GETHOVERTIME

	Lvm_getnumberofworkareas: INTEGER = 4169
			-- Version 4.71. Retrieves the number of working areas in a list
			-- view control.
			--
			-- Declared in Windows as LVM_GETNUMBEROFWORKAREAS

	Lvm_getsubitemrect: INTEGER = 4152
			-- Version 4.70. Retrieves information about the bounding
			-- rectangle for a subitem in a list view control.
			-- This message is intended to be used only with list view
			-- controls that use the Lvs_report style.
			--
			-- Declared in Windows as LVM_GETSUBITEMRECT

	Lvm_getworkareas: INTEGER = 4166
			-- Version 4.71. Retrieves the UNICODE character format flag for
			-- the control
			--
			-- Declared in Windows as LVM_GETWORKAREAS

	Lvm_setbkimage: INTEGER = 4164
			-- Version 4.71. Retrieves the UNICODE character format flag for
			-- the control
			--
			-- Declared in Windows as LVM_SETBKIMAGE

	Lvm_sethotcursor: INTEGER = 4158
			-- Version 4.70. Sets the HCURSOR value that the list view
			-- control uses when the pointer is over an item while hot
			-- tracking is enabled. To check whether or not
			-- hot tracking is enabled, call SystemParametersInfo.
			--
			-- Declared in Windows as LVM_SETHOTCURSOR

	Lvm_sethotitem: INTEGER = 4156
			-- Version 4.70.
			--
			-- Declared in Windows as LVM_SETHOTITEM

	Lvm_sethovertime: INTEGER = 4167
			-- Version 4.71. Sets the hot item for a list view control.
			--
			-- Declared in Windows as LVM_SETHOVERTIME

	Lvm_setworkareas: INTEGER = 4161
			-- Version 4.71. Sets the working areas within a list view
			-- control.
			--
			-- Declared in Windows as LVM_SETWORKAREAS

	Lvm_setselectionmark: INTEGER = 4163
			-- Version 4.71. Sets the selection mark in a list view control.
			--
			-- Declared in Windows as LVM_SETSELECTIONMARK

	Lvm_subitemhittest: INTEGER = 4153
			-- Version 4.70. Determines which list view item or subitem is
			-- at a given position.
			--
			-- Declared in Windows as LVM_SUBITEMHITTEST

feature -- Notifications

	Lvn_begindrag: INTEGER = -109
			-- Declared in Windows as LVN_BEGINDRAG

	Lvn_beginlabeledit: INTEGER = -175
			-- Declared in Windows as LVN_BEGINLABELEDIT

	Lvn_beginrdrag: INTEGER = -111
			-- Declared in Windows as LVN_BEGINRDRAG

	Lvn_columnclick: INTEGER = -108
			-- Declared in Windows as LVN_COLUMNCLICK

	Lvn_deleteallitems: INTEGER = -104
			-- Declared in Windows as LVN_DELETEALLITEMS

	Lvn_deleteitem: INTEGER = -103
			-- Declared in Windows as LVN_DELETEITEM

	Lvn_endlabeledit: INTEGER = -176
			-- Declared in Windows as LVN_ENDLABELEDIT

	Lvn_getdispinfo: INTEGER = -177
			-- Declared in Windows as LVN_GETDISPINFO

	Lvn_insertitem: INTEGER = -102
			-- Declared in Windows as LVN_INSERTITEM

	Lvn_itemchanged: INTEGER = -101
			-- Declared in Windows as LVN_ITEMCHANGED

	Lvn_itemchanging: INTEGER = -100
			-- Declared in Windows as LVN_ITEMCHANGING

	Lvn_keydown: INTEGER = -155
			-- Declared in Windows as LVN_KEYDOWN

	Lvn_setdispinfo: INTEGER = -178;
		-- Declared in Windows as LVN_SETDISPINFO

	Lvn_getinfotip: INTEGER = -157
			-- Version 4.71 and later of Comctl32.dll
			-- Sent by a large icon view list view control that has the
			-- LVS_EX_INFOTIP extended style. This notification is sent when
			-- the list view control is requesting additional text
			-- information to be displayed in a tooltip. It is sent in the
			-- form of a WM_NOTIFY message.
			--
			-- Declared in Windows as LVN_GETINFOTIP

	Lvn_marqueebegin: INTEGER = -156
			-- Declared in Windows as LVN_MARQUEEBEGIN

feature -- Header Notifications.

	Hdn_itemchanging, Hdn_itemchanginga: INTEGER = -300
	Hdn_itemchangingw: INTEGER = -320
			-- Notifies a header control's parent window that the attributes
			-- of a header item are about to change. This notification
			-- message is sent in the form of a WM_NOTIFY message.
			--
			-- Declared in Windows as HDN_ITEMCHANGING

	Hdn_itemchanged, Hdn_itemchangeda: INTEGER = -301
	Hdn_itemchangedw: INTEGER = -321
			-- Notifies a header control's parent window that the attributes
			-- of a header item have changed. This notification message is
			-- sent in the form of a WM_NOTIFY message.
			--
			-- Declared in Windows as HDN_ITEMCHANGED

	Hdn_itemclick, Hdn_itemclicka: INTEGER = -302
	Hdn_itemclickw: INTEGER = -322
			-- Notifies a header control's parent window that the user
			-- clicked the control. This notification message is sent in the
			-- form of a WM_NOTIFY message.
			--
			-- Declared in Windows as HDN_ITEMCLICK

	Hdn_itemdblclick, Hdn_itemdblclicka: INTEGER = -303
	Hdn_itemdblclickw: INTEGER = -323
			-- Notifies a header control's parent window that the user
			-- double-clicked the control. This notification message is sent
			-- in the form of a WM_NOTIFY message. Only header controls that
			-- are set to the HDS_BUTTONS style send this notification.
			--
			-- Declared in Windows as HDN_ITEMDBLCLICK

	Hdn_dividerdblclick, Hdn_dividerdblclicka: INTEGER = -305
	Hdn_dividerdblclickw: INTEGER = -325
			-- Notifies a header control's parent window that the user
			-- double-clicked the divider area of the control. This
			-- notification message is sent in the form of a WM_NOTIFY
			-- message.
			--
			-- Declared in Windows as HDN_DIVIDERDBLCLICK

	Hdn_begintrack, Hdn_begintracka: INTEGER = -306
	Hdn_begintrackw: INTEGER = -326
			-- Notifies a header control's parent window that the user has
			-- begun dragging a divider in the control (that is, the user
			-- has pressed the left mouse button while the mouse cursor is
			-- on a divider in the header control). This notification
			-- message is sent in the form of a WM_NOTIFY message.
			--
			-- Declared in Windows as HDN_BEGINTRACK

	Hdn_endtrack, Hdn_endtracka: INTEGER = -307
	Hdn_endtrackw: INTEGER = -327
			-- Notifies a header control's parent window that the user has
			-- finished dragging a divider. This notification message sent
			-- in the form of a WM_NOTIFY message.
			--
			-- Declared in Windows as HDN_ENDTRACK

	Hdn_track, Hdn_tracka: INTEGER = -308
	Hdn_trackw: INTEGER = -328
			-- Notifies a header control's parent window that the user is
			-- dragging a divider in the header control. This notification
			-- message is sent in the form of a WM_NOTIFY message.
			--
			-- Declared in Windows as HDN_TRACK

	Hdn_getdispinfo, Hdn_getdispinfoa: INTEGER = -309
	Hdn_getdispinfow: INTEGER = -329
			-- Version 4.70 and later of Comctl32.dll
			-- Notifies the header control's parent window when the filter
			-- button is clicked or in response to an HDM_SETITEM message.
			--
			-- Declared in Windows as HDN_GETDISPINFO

	Hdn_begindrag: INTEGER = -310
			-- Version 4.70 and later of Comctl32.dll
			-- Sent by a header control when a drag operation has begun on
			-- one of its items. This notification message is sent only by
			-- header controls that are set to the HDS_DRAGDROP style. This
			-- notification is sent in the form of a WM_NOTIFY message.
			--
			-- Declared in Windows as HDN_BEGINDRAG

	Hdn_enddrag: INTEGER = -311
			-- Version 4.70 and later of Comctl32.dll
			-- Sent by a header control when a drag operation has ended on
			-- one of its items. This notification is sent as a WM_NOTIFY
			-- message. Only header controls that are set to the
			-- HDS_DRAGDROP style send this notification.
			--
			-- Declared in Windows as HDN_ENDDRAG

feature -- HitTest Info.

	Lvht_above: INTEGER = 8
			-- Above the client area.
			--
			-- Declared in Windows as LVHT_ABOVE

	Lvht_below: INTEGER = 16
			-- Below the client area.
			--
			-- Declared in Windows as LVHT_BELOW

	Lvht_nowhere: INTEGER = 1
			-- In the client area, but below the last item.
			--
			-- Declared in Windows as LVHT_NOWHERE

	Lvht_onitemicon: INTEGER = 2
			-- On the button associated with an item.
			--
			-- Declared in Windows as LVHT_ONITEMICON

	Lvht_onitemlabel: INTEGER = 4
			-- On the label (string) associated with an item.
			--
			-- Declared in Windows as LVHT_ONITEMLABEL

	Lvht_onitemstateicon: INTEGER = 8
			-- On the state icon for a tree view item that is in
			-- a user-defines state.
			--
			-- Declared in Windows as LVHT_ONITEMSTATEICON

	Lvht_toleft: INTEGER = 64
			-- To the left of the client area.
			--
			-- Declared in Windows as LVHT_TOLEFT

	Lvht_toright: INTEGER = 32
			-- To the right of the client area.
			--
			-- Declared in Windows as LVHT_TORIGHT

feature -- Column Flags (General)

	Lvcf_fmt: INTEGER = 1
			-- The fmt member is valid.
			--
			-- Declared in Windows as LVCF_FMT

	Lvcf_subitem: INTEGER = 8
			-- The iSubItem member is valid.
			--
			-- Declared in Windows as LVCF_SUBITEM

	Lvcf_text: INTEGER = 4
			-- The pszText member is valid.
			--
			-- Declared in Windows as LVCF_TEXT

	Lvcf_width: INTEGER = 2
			-- The cx member is valid.
			--
			-- Declared in Windows as LVCF_WIDTH

	Lvcf_image: INTEGER = 16
			-- The ilmage member is valid
			--
			-- Declared in Windows as LVCF_IMAGE

feature -- Column Flags (Format)

	Lvcfmt_right: INTEGER = 1
			-- alignment of the column : right.
			-- Do not use for the first column of the list view
			-- that must always be left-aligned.
			--
			-- Declared in Windows as LVCFMT_RIGHT

	Lvcfmt_center: INTEGER = 2
			-- alignment of the column : center.
			-- Do not use for the first column of the list view
			-- that must always be left-aligned.
			--
			-- Declared in Windows as LVCFMT_CENTER

	Lvcfmt_left: INTEGER = 0
			-- alignment of the column : left.
			-- Do not use for the first column of the list view
			-- that must always be left-aligned.
			--
			-- Declared in Windows as LVCFMT_LEFT

	Lvcfmt_justifymask: INTEGER = 3
			-- alignment of the column : justify.
			-- Do not use for the first column of the list view
			-- that must always be left-aligned.
			--
			-- Declared in Windows as LVCFMT_JUSTIFYMASK

feature -- Column Flags (Width)

	Lvscw_autosize: INTEGER = -1
			-- Automatically sizes the column.
			--
			-- Declared in Windows as LVSCW_AUTOSIZE

	Lvscw_autosize_useheader: INTEGER = -2
			-- Automatically sizes the column to fit the
			-- header text. If you use this value with the last
			-- column, its width is set to fill the remaining
			-- width of the list view control.
			--
			-- Declared in Windows as LVSCW_AUTOSIZE_USEHEADER

feature -- Item flags

	Lvif_text: INTEGER = 1
			-- The pszText member is valid.
			--
			-- Declared in Windows as LVIF_TEXT

	Lvif_image: INTEGER = 2
			-- The iImage member is valid.
			--
			-- Declared in Windows as LVIF_IMAGE

	Lvif_param: INTEGER = 4
			-- The lParam member is valid.
			--
			-- Declared in Windows as LVIF_PARAM

	Lvif_state: INTEGER = 8
			-- The state member is valid
			--
			-- Declared in Windows as LVIF_STATE

feature -- Item Styles

	Lvis_cut: INTEGER = 4
			-- The item is marked for a cut and paste operation.
			--
			-- Declared in Windows as LVIS_CUT

	Lvis_drophilited: INTEGER = 8
			-- The item is highlighted as a drag-and-dop target.
			--
			-- Declared in Windows as LVIS_DROPHILITED

	Lvis_focused: INTEGER = 1
			-- The item has the focus.
			--
			-- Declared in Windows as LVIS_FOCUSED

	Lvis_selected: INTEGER = 2
			-- The item is selected.
			--
			-- Declared in Windows as LVIS_SELECTED

feature -- Next item flags

	Lvni_above: INTEGER = 256
			-- Searches for an item that is above the specified item.
			--
			-- Declared in Windows as LVNI_ABOVE

	Lvni_all: INTEGER = 0
			-- Searches for a subsequent item by index.
			--
			-- Declared in Windows as LVNI_ALL

	Lvni_below: INTEGER = 512
			-- Searches for an item that is below the specified item.
			--
			-- Declared in Windows as LVNI_BELOW

	Lvni_toleft: INTEGER = 1024
			-- Searches for an item to the left of the specified item.
			--
			-- Declared in Windows as LVNI_TOLEFT

	Lvni_toright: INTEGER = 2048
			-- Searches for an item to the right of the specified item.
			--
			-- Declared in Windows as LVNI_TORIGHT

	Lvni_cut: INTEGER = 4
			-- The item has the LVIS_CUT state flag set.
			--
			-- Declared in Windows as LVNI_CUT

	Lvni_drophilited: INTEGER = 8
			-- The item has the LVIS_DROPHILITED state flag set.
			--
			-- Declared in Windows as LVNI_DROPHILITED

	Lvni_focused: INTEGER = 1
			-- The item has the LVIS_FOCUSED state flag set.
			--
			-- Declared in Windows as LVNI_FOCUSED

	Lvni_selected: INTEGER = 2
			-- The item has the LVIS_SELECTED state flag set.
			--
			-- Declared in Windows as LVNI_SELECTED

feature -- ImageList State

	Lvsil_normal: INTEGER = 0
			-- Indicates the normal image list, which contains
			-- selected, nonselected, and overlay images for the
			-- items of a list view control.
			-- This image list represents the large icons.
			--
			-- Declared in Windows as LVSIL_NORMAL

	Lvsil_small: INTEGER = 1
			-- Indicates the normal image list, which contains
			-- selected, nonselected, and overlay images for the
			-- items of a list view control.
			-- This image list represents the small icons.
			--
			-- Declared in Windows as LVSIL_SMALL

	Lvsil_state: INTEGER = 2
			-- Indicates the state image list. You can use state
			-- images to indicate application-defined item states.
			-- A state image is displayed to the left of an item's
			-- selected or nonselected image.
			--
			-- Declared in Windows as LVSIL_STATE

feature -- Flags defining search in a list view.
		--| Used in WEL_LIST_VIEW_SEARCH_INFO

	Lvfi_param: INTEGER = 1
			-- Search item with corresponding lparam attribute
			--
			-- Declared in Windows as LVFI_PARAM

	Lvfi_partial: INTEGER = 8
			-- Search item including given string
			--
			-- Declared in Windows as LVFI_PARTIAL

	Lvfi_string: INTEGER = 2
			-- Search item with exact corresponding string
			--
			-- Declared in Windows as LVFI_STRING

	Lvfi_wrap: INTEGER = 32
			-- Start search from start when end of list view is reached
			--
			-- Declared in Windows as LVFI_WRAP

	Lvfi_nearestxy: INTEGER = 64
			-- Search item nearest specified position in specified direction
			--
			-- Declared in Windows as LVFI_NEARESTXY

feature -- List View Item Rectangle constants.

	Lvir_bounds: INTEGER = 0
			-- Returns the bounding rectangle of the entire item, including
			-- the icon and label.
			--
			-- Declared in Windows as LVIR_BOUNDS

	Lvir_icon: INTEGER = 1
			-- Returns the bounding rectangle of the icon or small icon.
			--
			-- Declared in Windows as LVIR_ICON

	Lvir_label: INTEGER = 2
			-- Returns the bounding rectangle of the item text.
			--
			-- Declared in Windows as LVIR_LABEL

	Lvir_selectbounds: INTEGER = 3
			-- Returns the union of the LVIR_ICON and LVIR_LABEL rectangles,
			-- but excludes columns in report view.
			--
			-- Declared in Windows as LVIR_SELECTBOUNDS

feature -- Validation

	is_valid_list_view_flag (a_flag: INTEGER): BOOLEAN
			-- Is `a_flag' a valid list view search flag?
		do
			Result := a_flag = Lvfi_param or a_flag = Lvfi_partial
						or a_flag = Lvfi_string or a_flag = Lvfi_wrap
						or a_flag = Lvfi_nearestxy
		end

	valid_lvcfmt_constant (value: INTEGER): BOOLEAN
			-- Is `value' a valid lvcfmt constant?
		do
			Result := value = Lvcfmt_left or else
				value = Lvcfmt_center or else
				value = Lvcfmt_right or else
				value = Lvcfmt_justifymask
		end

	valid_lvis_constants (value: INTEGER): BOOLEAN
			-- Is `value' a valid "Item Styles" constant?
		do
			Result := value = Lvis_cut or else
				value = Lvis_drophilited or else
				value = Lvis_focused or else
				value = Lvis_selected
		end

	valid_lvir_constant (value: INTEGER): BOOLEAN
			-- Is `value' a valid item lvir item bounding constant?
		do
			Result := value = lvir_bounds or else
				value = lvir_icon or else
				value = lvir_label or else
				value = lvir_selectbounds
		end

note
	copyright:	"Copyright (c) 1984-2011, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class WEL_LIST_VIEW_CONSTANTS

