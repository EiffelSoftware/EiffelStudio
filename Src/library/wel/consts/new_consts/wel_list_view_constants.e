indexing
	description	: "ListView Control Constants."
	status		: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"

class
	WEL_LIST_VIEW_CONSTANTS

feature -- Style

	Lvs_icon: INTEGER is 0
			-- This style specifies icon view. 
			--
			-- Declared in Windows as LVS_ICON

	Lvs_report: INTEGER is 1
			-- This style specifies report view. When using the LVS_REPORT
			-- style with a list view control, the first column is always
			-- left-aligned. You cannot use LVCFMT_RIGHT to change this
			-- alignment. See LVCOLUMN for further information on column
			-- alignment. 
			--
			-- Declared in Windows as LVS_REPORT

	Lvs_smallicon: INTEGER is 2
			-- This style specifies small icon view. 
			--
			-- Declared in Windows as LVS_SMALLICON

	Lvs_list: INTEGER is 3
			-- This style specifies list view. 
			--
			-- Declared in Windows as LVS_LIST

	Lvs_alignleft: INTEGER is 2048
			-- Items are left-aligned in icon and small icon view. 
			--
			-- Declared in Windows as LVS_ALIGNLEFT

	Lvs_aligntop: INTEGER is 0
			-- Items are aligned with the top of the list view control in
			-- icon and small icon view. 
			--
			-- Declared in Windows as LVS_ALIGNTOP

	Lvs_autoarrange: INTEGER is 256
			-- Icons are automatically kept arranged in icon and small icon
			-- view. 
			--
			-- Declared in Windows as LVS_AUTOARRANGE

	Lvs_editlabels: INTEGER is 512
			-- Item text can be edited in place. The parent window must
			-- process the LVN_ENDLABELEDIT notification message. 
			--
			-- Declared in Windows as LVS_EDITLABELS

	Lvs_nocolumnheader: INTEGER is 16384
			-- Declared in Windows as LVS_NOCOLUMNHEADER
	
	Lvs_nosortheader: INTEGER is 32768
			-- Column headers do not work like buttons. This style can be
			-- used if clicking a column header in report view does not
			-- carry out an action, such as sorting. 
			--
			-- Declared in Windows as LVS_NOSORTHEADER

	Lvs_nolabelwrap: INTEGER is 128
			-- Item text is displayed on a single line in icon view. By
			-- default, item text may wrap in icon view. 
			--
			-- Declared in Windows as LVS_NOLABELWRAP

	Lvs_noscroll: INTEGER is 8192
			-- Scrolling is disabled. All items must be within the client
			-- area. This style is not compatible with the LVS_LIST or
			-- LVS_REPORT styles.
			-- 
			-- Declared in Windows as LVS_NOSCROLL

	Lvs_ownerdrawfixed: INTEGER is 1024
			-- The owner window can paint items in report view. The list
			-- view control sends a WM_DRAWITEM message to paint each item;
			-- it does not send separate messages for each subitem. The
			-- itemData member of the DRAWITEMSTRUCT structure contains the
			-- item data for the specified list view item. 
			--
			-- Declared in Windows as LVS_OWNERDRAWFIXED

	Lvs_shareimagelists: INTEGER is 64
			-- The image list will not be deleted when the control is
			-- destroyed. This style enables the use of the same image lists
			-- with multiple list view controls. 
			--
			-- Declared in Windows as LVS_SHAREIMAGELISTS

	Lvs_showselalways: INTEGER is 8
			-- The selection, if any, is always shown, even if the control
			-- does not have the focus. 
			--
			-- Declared in Windows as LVS_SHOWSELALWAYS

	Lvs_singlesel: INTEGER is 4
			-- Only one item at a time can be selected. By default, multiple
			-- items may be selected. 
			--
			-- Declared in Windows as LVS_SINGLESEL

	Lvs_sortascending: INTEGER is 16
			-- Item indices are sorted based on item text in ascending
			-- order. 
			--
			-- Declared in Windows as LVS_SORTASCENDING

	Lvs_sortdescending: INTEGER is 32
			-- Item indices are sorted based on item text in descending
			-- order. 
			--
			-- Declared in Windows as LVS_SORTDESCENDING

feature -- Extended Style

	Lvs_ex_checkboxes: INTEGER is 4
			-- Version 4.70.
			-- Enables check boxes for items in a list view
			-- control. Effectively, when set to this style, the control 
			-- will create and set a state image list using 
			-- DrawFrameControl. Check boxes are visible and functional 
			-- with all list view modes. You can obtain the state of the 
			-- check box for a given item with ListView_GetCheckState. To 
			-- set the check state, use ListView_SetCheckState. 

	Lvs_ex_flatsb: INTEGER is 256
			-- Version 4.71. 
			-- Enables flat scroll bars in the list view. 
			-- If you need more control over the appearance of the list
			-- view's scroll bars, you should manipulate the list view's 
			-- scroll bars directly using the Flat Scroll Bar APIs. If
			-- the system metrics change, you are responsible for adjusting
			-- the scrollbar metrics with FlatSB_SetScrollProp. See Flat
			-- Scroll Bars for further details. 

	Lvs_ex_fullrowselect: INTEGER is 32
			-- Version 4.70.
			-- When an item is selected, the item and all its subitems are
			-- highlighted. This style is available only in conjunction
			-- with the LVS_REPORT style. 

	Lvs_ex_gridlines: INTEGER is 1
			-- Version 4.70. Displays gridlines around items and subitems.
			-- This style is available only in conjunction with the LVS_REPORT
			-- style. 

	Lvs_ex_headerdragdrop: INTEGER is 16
			-- Version 4.70. Enables drag-and-drop reordering of columns in
			-- a list view control. This style is only available to list
			-- view controls that use the LVS_REPORT style. 

	Lvs_ex_infotip: INTEGER is 1024
			-- Version 4.71. When a list view control uses the 
			-- LVS_EX_INFOTIP style, the LVN_GETINFOTIP notification message
			-- is sent to the parent window before displaying an item's
			-- tooltip. 

	Lvs_ex_labeltip: INTEGER is 16384
			-- Version 5.80. If a partially hidden label in any list view
			-- mode lacks tooltip text, the list view control will unfold
			-- the label. If this style is not set, the list view control
			-- will unfold partly hidden labels only for the large icon mode. 

	Lvs_ex_multiworkareas: INTEGER is 8192
			-- Version 4.71. If the list view control has the LVS_AUTOARRANGE
			-- style, the control will not autoarrange its icons until one or
			-- more work areas are defined (see LVM_SETWORKAREAS). To be
			-- effective, this style must be set before any work areas are 
			-- defined and any items have been added to the control. 

	Lvs_ex_oneclickactivate: INTEGER is 64
			-- Version 4.70. The list view control sends an LVN_ITEMACTIVATE 
			-- notification message to the parent window when the user clicks
			-- an item. This style also enables hot tracking in the list view
			-- control. Hot tracking means that when the cursor moves over an
			-- item, it is highlighted but not selected. See the Remarks for a 
			-- discussion of item activation. 

	Lvs_ex_regional: INTEGER is 512
			-- Version 4.71. The list view will create a region that includes 
			-- only the item icons and text and set its window region to that 
			-- using SetWindowRgn. This will exclude any area that is not part
			-- of an item from the window region. This style is only available
			-- to list view controls that use the LVS_ICON style. 

	Lvs_ex_subitemimages: INTEGER is 2
			-- Version 4.70. Allows images to be displayed for subitems. 
			-- This style is available only in conjunction with the LVS_REPORT 
			-- style. 

	Lvs_ex_trackselect: INTEGER is 8
			-- Version 4.70. Enables hot-track selection in a list view 
			-- control. Hot track selection means that an item is 
			-- automatically selected when the cursor remains over the item 
			-- for a certain period of time. The delay can be changed from 
			-- the default system setting with a LVM_SETHOVERTIME message. 
			-- This style applies to all styles of list view control. You 
			-- can check whether or not hot-track selection is enabled by 
			-- calling SystemParametersInfo. 

	Lvs_ex_twoclickactivate: INTEGER is 128
			-- Version 4.70. The list view control sends an LVN_ITEMACTIVATE 
			-- notification message to the parent window when the user 
			-- double-clicks an item. This style also enables hot tracking 
			-- in the list view control. Hot tracking means that when the 
			-- cursor moves over an item, it is highlighted but not 
			-- selected. See the Remarks for a discussion of item 
			-- activation. 

	Lvs_ex_underlinecold: INTEGER is 4096
			-- Version 4.71. Causes non-hot items that are activatable to be 
			-- displayed with underlined text. This style requires that 
			-- LVS_EX_TWOCLICKACTIVATE also be set. See the Remarks for a 
			-- discussion of item activation. 

	Lvs_ex_underlinehot: INTEGER is 2048
			-- Version 4.71. Causes hot items that are activatable to be 
			-- displayed with underlined text. This style requires that 
			-- LVS_EX_ONECLICKACTIVATE or LVS_EX_TWOCLICKACTIVATE also be 
			-- set. See the Remarks for a discussion of item activation. 

feature -- Messages

	Lvm_arrange: INTEGER is 4118
			-- Declared in Windows as LVM_ARRANGE

	Lvm_createdragimage: INTEGER is 4129
			-- Declared in Windows as LVM_CREATEDRAGIMAGE

	Lvm_deleteallitems: INTEGER is 4105
			-- Declared in Windows as LVM_DELETEALLITEMS

	Lvm_deletecolumn: INTEGER is 4124
			-- Declared in Windows as LVM_DELETECOLUMN

	Lvm_deleteitem: INTEGER is 4104
			-- Declared in Windows as LVM_DELETEITEM

	Lvm_editlabel: INTEGER is 4119
			-- Declared in Windows as LVM_EDITLABEL

	Lvm_ensurevisible: INTEGER is 4115
			-- Declared in Windows as LVM_ENSUREVISIBLE

	Lvm_finditem: INTEGER is 4109
			-- Declared in Windows as LVM_FINDITEM

	Lvm_getbkcolor: INTEGER is 4096
			-- Declared in Windows as LVM_GETBKCOLOR

	Lvm_getcallbackmask: INTEGER is 4106
			-- Declared in Windows as LVM_GETCALLBACKMASK

	Lvm_getcolumn: INTEGER is 4121
			-- Declared in Windows as LVM_GETCOLUMN

	Lvm_getcolumnwidth: INTEGER is 4125
			-- Declared in Windows as LVM_GETCOLUMNWIDTH

	Lvm_getcountperpage: INTEGER is 4136
			-- Declared in Windows as LVM_GETCOUNTPERPAGE

	Lvm_geteditcontrol: INTEGER is 4120
			-- Declared in Windows as LVM_GETEDITCONTROL

	Lvm_getimagelist: INTEGER is 4098
			-- Declared in Windows as LVM_GETIMAGELIST

	Lvm_getisearchstring: INTEGER is 4148
			-- Declared in Windows as LVM_GETISEARCHSTRING

	Lvm_getitem: INTEGER is 4101
			-- Declared in Windows as LVM_GETITEM

	Lvm_getitemcount: INTEGER is 4100
			-- Declared in Windows as LVM_GETITEMCOUNT

	Lvm_getitemposition: INTEGER is 4112
			-- Declared in Windows as LVM_GETITEMPOSITION

	Lvm_getitemrect: INTEGER is 4110
			-- Declared in Windows as LVM_GETITEMRECT

	Lvm_getitemspacing: INTEGER is 4147
			-- Declared in Windows as LVM_GETITEMSPACING

	Lvm_getitemstate: INTEGER is 4140
			-- Declared in Windows as LVM_GETITEMSTATE

	Lvm_getitemtext: INTEGER is 4141
			-- Declared in Windows as LVM_GETITEMTEXT

	Lvm_gettooltips: INTEGER is 4174
			-- Retrieves the tooltip control that the list
			-- view control uses to display tooltips. 
			--
			-- Declared in Windows as LVM_GETTOOLTIPS

	Lvm_getnextitem: INTEGER is 4108
			-- Declared in Windows as LVM_GETNEXTITEM

	Lvm_getorigin: INTEGER is 4137
			-- Declared in Windows as LVM_GETORIGIN

	Lvm_getselectedcount: INTEGER is 4146
			-- Declared in Windows as LVM_GETSELECTEDCOUNT

	Lvm_getstringwidth: INTEGER is 4113
			-- Declared in Windows as LVM_GETSTRINGWIDTH

	Lvm_gettextbkcolor: INTEGER is 4133
			-- Declared in Windows as LVM_GETTEXTBKCOLOR

	Lvm_gettextcolor: INTEGER is 4131
			-- Declared in Windows as LVM_GETTEXTCOLOR

	Lvm_gettopindex: INTEGER is 4135
			-- Declared in Windows as LVM_GETTOPINDEX

	Lvm_getunicodeformat: INTEGER is 8198
			-- Retrieves the UNICODE character format flag for
			-- the control
			--
			-- Declared in Windows as LVM_GETUNICODEFORMAT

	Lvm_getviewrect: INTEGER is 4130
			-- Declared in Windows as LVM_GETVIEWRECT

	Lvm_hittest: INTEGER is 4114
			-- Declared in Windows as LVM_HITTEST

	Lvm_insertcolumn: INTEGER is 4123
			-- Declared in Windows as LVM_INSERTCOLUMN

	Lvm_insertitem: INTEGER is 4103
			-- Declared in Windows as LVM_INSERTITEM

	Lvm_redrawitems: INTEGER is 4117
			-- Declared in Windows as LVM_REDRAWITEMS

	Lvm_scroll: INTEGER is 4116
			-- Declared in Windows as LVM_SCROLL

	Lvm_setbkcolor: INTEGER is 4097
			-- Declared in Windows as LVM_SETBKCOLOR

	Lvm_setcallbackmask: INTEGER is 4107
			-- Declared in Windows as LVM_SETCALLBACKMASK

	Lvm_setcolumn: INTEGER is 4122
			-- Declared in Windows as LVM_SETCOLUMN

	Lvm_setcolumnwidth: INTEGER is 4126
			-- Declared in Windows as LVM_SETCOLUMNWIDTH

	Lvm_setimagelist: INTEGER is 4099
			-- Declared in Windows as LVM_SETIMAGELIST

	Lvm_setitem: INTEGER is 4102
			-- Declared in Windows as LVM_SETITEM

	Lvm_setitemcount: INTEGER is 4143
			-- Declared in Windows as LVM_SETITEMCOUNT

	Lvm_setitemposition: INTEGER is 4111
			-- Declared in Windows as LVM_SETITEMPOSITION

	Lvm_setitemposition32: INTEGER is 4145
			-- Declared in Windows as LVM_SETITEMPOSITION32

	Lvm_setitemstate: INTEGER is 4139
			-- Declared in Windows as LVM_SETITEMSTATE

	Lvm_setitemtext: INTEGER is 4142
			-- Declared in Windows as LVM_SETITEMTEXT

	Lvm_settextbkcolor: INTEGER is 4134
			-- Declared in Windows as LVM_SETTEXTBKCOLOR

	Lvm_settextcolor: INTEGER is 4132
			-- Declared in Windows as LVM_SETTEXTCOLOR

	Lvm_settooltips: INTEGER is 4170
			-- Sets the tooltip control that the list view
			-- control will use to display tooltips. You can send this
			-- message explicitly or use the ListView_SetToolTips macro
			--
			-- Declared in Windows as LVM_SETTOOLTIPS

	Lvm_sortitems: INTEGER is 4144
			-- Declared in Windows as LVM_SORTITEMS

	Lvm_setunicodeformat: INTEGER is 8197
			-- Sets the UNICODE character format flag for the
			-- control. This message allows you to change the character set
			-- used by the control at run time rather than having to re
			-- create the control.
			--
			-- Declared in Windows as LVM_SETUNICODEFORMAT

	Lvm_update: INTEGER is 4138
			-- Declared in Windows as LVM_UPDATE


	Lvm_approximateviewrect: INTEGER is 4160
			-- Version 4.70. Calculates the approximate width and height
			-- required to display a given number of items.
			--
			-- Declared in Windows as LVM_APPROXIMATEVIEWRECT

	Lvm_getbkimage: INTEGER is 4165
			-- Version 4.71. Retrieves the background image in a list view
			-- control.
			--
			-- Declared in Windows as LVM_GETBKIMAGE

	Lvm_getcolumnorderarray: INTEGER is 4155
			-- Version 4.70. Retrieves the current left-to-right order of
			-- columns in a list view control.
			--
			-- Declared in Windows as LVM_GETCOLUMNORDERARRAY

	Lvm_getextendedlistviewstyle: INTEGER is 4151
			-- Version 4.70. Retrieves the extended styles that are
			-- currently in use for a given list view control.
			--
			-- Declared in Windows as LVM_GETEXTENDEDLISTVIEWSTYLE

	Lvm_setextendedlistviewstyle: INTEGER is 4150
			-- Version 4.70. Sets extended styles in list view controls.
			--
			-- Declared in Windows as LVM_SETEXTENDEDLISTVIEWSTYLE

	Lvm_getheader: INTEGER is 4127
			-- Version 4.70. Retrieves the handle to the header control used
			-- by the list view control. 
			--
			-- Declared in Windows as LVM_GETHEADER

	Lvm_gethotcursor: INTEGER is 4159
			-- Version 4.70. Retrieves the HCURSOR value used when the
			-- pointer is over an item while hot tracking is enabled
			--
			-- Declared in Windows as LVM_GETHOTCURSOR

	Lvm_gethotitem: INTEGER is 4157
			-- Version 4.70. Retrieves the index of the hot item. 
			--
			-- Declared in Windows as LVM_GETHOTITEM

	Lvm_gethovertime: INTEGER is 4168
			-- Version 4.71. Retrieves the amount of time that the mouse
			-- cursor must hover over an item before it is selected.
			--
			-- Declared in Windows as LVM_GETHOVERTIME

	Lvm_getnumberofworkareas: INTEGER is 4169
			-- Version 4.71. Retrieves the number of working areas in a list
			-- view control. 
			--
			-- Declared in Windows as LVM_GETNUMBEROFWORKAREAS

	Lvm_getsubitemrect: INTEGER is 4152
			-- Version 4.70. Retrieves information about the bounding
			-- rectangle for a subitem in a list view control. 
			-- This message is intended to be used only with list view
			-- controls that use the Lvs_report style. 
			--
			-- Declared in Windows as LVM_GETSUBITEMRECT

	Lvm_getworkareas: INTEGER is 4166
			-- Version 4.71. Retrieves the UNICODE character format flag for
			-- the control
			--
			-- Declared in Windows as LVM_GETWORKAREAS

	Lvm_setbkimage: INTEGER is 4164
			-- Version 4.71. Retrieves the UNICODE character format flag for
			-- the control
			--
			-- Declared in Windows as LVM_SETBKIMAGE

	Lvm_sethotcursor: INTEGER is 4158
			-- Version 4.70. Sets the HCURSOR value that the list view
			-- control uses when the pointer is over an item while hot
			-- tracking is enabled. To check whether or not
			-- hot tracking is enabled, call SystemParametersInfo. 
			--
			-- Declared in Windows as LVM_SETHOTCURSOR

	Lvm_sethotitem: INTEGER is 4156
			-- Version 4.70. 
			--
			-- Declared in Windows as LVM_SETHOTITEM

	Lvm_sethovertime: INTEGER is 4167
			-- Version 4.71. Sets the hot item for a list view control. 
			--
			-- Declared in Windows as LVM_SETHOVERTIME

	Lvm_setworkareas: INTEGER is 4161
			-- Version 4.71. Sets the working areas within a list view
			-- control. 
			--
			-- Declared in Windows as LVM_SETWORKAREAS

	Lvm_setselectionmark: INTEGER is 4163
			-- Version 4.71. Sets the selection mark in a list view control.
			--
			-- Declared in Windows as LVM_SETSELECTIONMARK

	Lvm_subitemhittest: INTEGER is 4153
			-- Version 4.70. Determines which list view item or subitem is
			-- at a given position. 
			--
			-- Declared in Windows as LVM_SUBITEMHITTEST

feature -- Notifications

	Lvn_begindrag: INTEGER is -109
			-- Declared in Windows as LVN_BEGINDRAG

	Lvn_beginlabeledit: INTEGER is -105
			-- Declared in Windows as LVN_BEGINLABELEDIT

	Lvn_beginrdrag: INTEGER is -111
			-- Declared in Windows as LVN_BEGINRDRAG

	Lvn_columnclick: INTEGER is -108
			-- Declared in Windows as LVN_COLUMNCLICK

	Lvn_deleteallitems: INTEGER is -104
			-- Declared in Windows as LVN_DELETEALLITEMS

	Lvn_deleteitem: INTEGER is -103
			-- Declared in Windows as LVN_DELETEITEM

	Lvn_endlabeledit: INTEGER is -106
			-- Declared in Windows as LVN_ENDLABELEDIT

	Lvn_getdispinfo: INTEGER is -150
			-- Declared in Windows as LVN_GETDISPINFO

	Lvn_insertitem: INTEGER is -102
			-- Declared in Windows as LVN_INSERTITEM

	Lvn_itemchanged: INTEGER is -101
			-- Declared in Windows as LVN_ITEMCHANGED

	Lvn_itemchanging: INTEGER is -100
			-- Declared in Windows as LVN_ITEMCHANGING

	Lvn_keydown: INTEGER is -155
			-- Declared in Windows as LVN_KEYDOWN

	Lvn_setdispinfo: INTEGER is -151
			-- Declared in Windows as LVN_SETDISPINFO

	Lvn_getinfotip: INTEGER is -157
			-- Version 4.71 and later of Comctl32.dll
			-- Sent by a large icon view list view control that has the
			-- LVS_EX_INFOTIP extended style. This notification is sent when
			-- the list view control is requesting additional text
			-- information to be displayed in a tooltip. It is sent in the
			-- form of a WM_NOTIFY message.
			--
			-- Declared in Windows as LVN_GETINFOTIP

	Lvn_marqueebegin: INTEGER is -156
			-- Declared in Windows as LVN_MARQUEEBEGIN

feature -- Header Notifications.

	Hdn_itemchanging, Hdn_itemchanginga: INTEGER is -300
	Hdn_itemchangingw: INTEGER is -320
			-- Notifies a header control's parent window that the attributes 
			-- of a header item are about to change. This notification 
			-- message is sent in the form of a WM_NOTIFY message. 
			--
			-- Declared in Windows as HDN_ITEMCHANGING

	Hdn_itemchanged, Hdn_itemchangeda: INTEGER is -301
	Hdn_itemchangedw: INTEGER is -321
			-- Notifies a header control's parent window that the attributes 
			-- of a header item have changed. This notification message is 
			-- sent in the form of a WM_NOTIFY message. 
			--
			-- Declared in Windows as HDN_ITEMCHANGED

	Hdn_itemclick, Hdn_itemclicka: INTEGER is -302
	Hdn_itemclickw: INTEGER is -322
			-- Notifies a header control's parent window that the user 
			-- clicked the control. This notification message is sent in the 
			-- form of a WM_NOTIFY message. 
			--
			-- Declared in Windows as HDN_ITEMCLICK

	Hdn_itemdblclick, Hdn_itemdblclicka: INTEGER is -303
	Hdn_itemdblclickw: INTEGER is -323
			-- Notifies a header control's parent window that the user 
			-- double-clicked the control. This notification message is sent 
			-- in the form of a WM_NOTIFY message. Only header controls that 
			-- are set to the HDS_BUTTONS style send this notification. 
			--
			-- Declared in Windows as HDN_ITEMDBLCLICK

	Hdn_dividerdblclick, Hdn_dividerdblclicka: INTEGER is -305
	Hdn_dividerdblclickw: INTEGER is -325
			-- Notifies a header control's parent window that the user 
			-- double-clicked the divider area of the control. This 
			-- notification message is sent in the form of a WM_NOTIFY 
			-- message. 
			--
			-- Declared in Windows as HDN_DIVIDERDBLCLICK

	Hdn_begintrack, Hdn_begintracka: INTEGER is -306
	Hdn_begintrackw: INTEGER is -326
			-- Notifies a header control's parent window that the user has 
			-- begun dragging a divider in the control (that is, the user 
			-- has pressed the left mouse button while the mouse cursor is 
			-- on a divider in the header control). This notification 
			-- message is sent in the form of a WM_NOTIFY message. 
			--
			-- Declared in Windows as HDN_BEGINTRACK

	Hdn_endtrack, Hdn_endtracka: INTEGER is -307
	Hdn_endtrackw: INTEGER is -327
			-- Notifies a header control's parent window that the user has 
			-- finished dragging a divider. This notification message sent 
			-- in the form of a WM_NOTIFY message. 
			--
			-- Declared in Windows as HDN_ENDTRACK

	Hdn_track, Hdn_tracka: INTEGER is -308
	Hdn_trackw: INTEGER is -328
			-- Notifies a header control's parent window that the user is 
			-- dragging a divider in the header control. This notification 
			-- message is sent in the form of a WM_NOTIFY message. 
			--
			-- Declared in Windows as HDN_TRACK

	Hdn_getdispinfo, Hdn_getdispinfoa: INTEGER is -309
	Hdn_getdispinfow: INTEGER is -329
			-- Version 4.70 and later of Comctl32.dll
			-- Notifies the header control's parent window when the filter 
			-- button is clicked or in response to an HDM_SETITEM message. 
			-- 
			-- Declared in Windows as HDN_GETDISPINFO

	Hdn_begindrag: INTEGER is -310
			-- Version 4.70 and later of Comctl32.dll
			-- Sent by a header control when a drag operation has begun on 
			-- one of its items. This notification message is sent only by 
			-- header controls that are set to the HDS_DRAGDROP style. This 
			-- notification is sent in the form of a WM_NOTIFY message. 
			--
			-- Declared in Windows as HDN_BEGINDRAG

	Hdn_enddrag: INTEGER is -311
			-- Version 4.70 and later of Comctl32.dll
			-- Sent by a header control when a drag operation has ended on 
			-- one of its items. This notification is sent as a WM_NOTIFY 
			-- message. Only header controls that are set to the 
			-- HDS_DRAGDROP style send this notification. 
			--
			-- Declared in Windows as HDN_ENDDRAG

feature -- HitTest Info.

	Lvht_above: INTEGER is 8
			-- Above the client area.
			--
			-- Declared in Windows as LVHT_ABOVE

	Lvht_below: INTEGER is 16
			-- Below the client area.
			--
			-- Declared in Windows as LVHT_BELOW

	Lvht_nowhere: INTEGER is 1
			-- In the client area, but below the last item.
			--
			-- Declared in Windows as LVHT_NOWHERE

	Lvht_onitemicon: INTEGER is 2
			-- On the button associated with an item.
			--
			-- Declared in Windows as LVHT_ONITEMICON

	Lvht_onitemlabel: INTEGER is 4
			-- On the label (string) associated with an item.
			--
			-- Declared in Windows as LVHT_ONITEMLABEL

	Lvht_onitemstateicon: INTEGER is 8
			-- On the state icon for a tree view item that is in
			-- a user-defines state.
			--
			-- Declared in Windows as LVHT_ONITEMSTATEICON

	Lvht_toleft: INTEGER is 64
			-- To the left of the client area.
			--
			-- Declared in Windows as LVHT_TOLEFT

	Lvht_toright: INTEGER is 32
			-- To the right of the client area.
			--
			-- Declared in Windows as LVHT_TORIGHT

feature -- Column Flags (General)

	Lvcf_fmt: INTEGER is 1
			-- The fmt member is valid.
			--
			-- Declared in Windows as LVCF_FMT

	Lvcf_subitem: INTEGER is 8
			-- The iSubItem member is valid.
			--
			-- Declared in Windows as LVCF_SUBITEM

	Lvcf_text: INTEGER is 4
			-- The pszText member is valid.
			--
			-- Declared in Windows as LVCF_TEXT

	Lvcf_width: INTEGER is 2
			-- The cx member is valid.
			--
			-- Declared in Windows as LVCF_WIDTH

	Lvcf_image: INTEGER is 16
			-- The ilmage member is valid
			--
			-- Declared in Windows as LVCF_IMAGE

feature -- Column Flags (Format)

	Lvcfmt_right: INTEGER is 1
			-- alignment of the column : right.
			-- Do not use for the first column of the list view
			-- that must always be left-aligned.
			--
			-- Declared in Windows as LVCFMT_RIGHT

	Lvcfmt_center: INTEGER is 2
			-- alignment of the column : center.
			-- Do not use for the first column of the list view
			-- that must always be left-aligned.
			--
			-- Declared in Windows as LVCFMT_CENTER

	Lvcfmt_left: INTEGER is 0
			-- alignment of the column : left.
			-- Do not use for the first column of the list view
			-- that must always be left-aligned.
			--
			-- Declared in Windows as LVCFMT_LEFT

	Lvcfmt_justifymask: INTEGER is 3
			-- alignment of the column : justify.
			-- Do not use for the first column of the list view
			-- that must always be left-aligned.
			--
			-- Declared in Windows as LVCFMT_JUSTIFYMASK

feature -- Column Flags (Width)

	Lvscw_autosize: INTEGER is -1
			-- Automatically sizes the column.
			--
			-- Declared in Windows as LVSCW_AUTOSIZE

	Lvscw_autosize_useheader: INTEGER is -2
			-- Automatically sizes the column to fit the 
			-- header text. If you use this value with the last 
			-- column, its width is set to fill the remaining 
			-- width of the list view control.
			--
			-- Declared in Windows as LVSCW_AUTOSIZE_USEHEADER

feature -- Item flags

	Lvif_text: INTEGER is 1
			-- The pszText member is valid.
			--
			-- Declared in Windows as LVIF_TEXT

	Lvif_image: INTEGER is 2
			-- The iImage member is valid.
			--
			-- Declared in Windows as LVIF_IMAGE

	Lvif_param: INTEGER is 4
			-- The lParam member is valid.
			--
			-- Declared in Windows as LVIF_PARAM

	Lvif_state: INTEGER is 8
			-- The state member is valid
			--
			-- Declared in Windows as LVIF_STATE

feature -- Item Styles

	Lvis_cut: INTEGER is 4
			-- The item is marked for a cut and paste operation.
			--
			-- Declared in Windows as LVIS_CUT

	Lvis_drophilited: INTEGER is 8
			-- The item is highlighted as a drag-and-dop target.
			--
			-- Declared in Windows as LVIS_DROPHILITED

	Lvis_focused: INTEGER is 1
			-- The item has the focus.
			--
			-- Declared in Windows as LVIS_FOCUSED

	Lvis_selected: INTEGER is 2
			-- The item is selected.
			--
			-- Declared in Windows as LVIS_SELECTED

feature -- Next item flags

	Lvni_above: INTEGER is 256
			-- Searches for an item that is above the specified item.
			--
			-- Declared in Windows as LVNI_ABOVE

	Lvni_all: INTEGER is 0
			-- Searches for a subsequent item by index.
			--
			-- Declared in Windows as LVNI_ALL

	Lvni_below: INTEGER is 512
			-- Searches for an item that is below the specified item.
			--
			-- Declared in Windows as LVNI_BELOW

	Lvni_toleft: INTEGER is 1024
			-- Searches for an item to the left of the specified item.
			--
			-- Declared in Windows as LVNI_TOLEFT

	Lvni_toright: INTEGER is 2048
			-- Searches for an item to the right of the specified item.
			--
			-- Declared in Windows as LVNI_TORIGHT

	Lvni_cut: INTEGER is 4
			-- The item has the LVIS_CUT state flag set.
			--
			-- Declared in Windows as LVNI_CUT

	Lvni_drophilited: INTEGER is 8
			-- The item has the LVIS_DROPHILITED state flag set.
			--
			-- Declared in Windows as LVNI_DROPHILITED

	Lvni_focused: INTEGER is 1
			-- The item has the LVIS_FOCUSED state flag set.
			--
			-- Declared in Windows as LVNI_FOCUSED

	Lvni_selected: INTEGER is 2
			-- The item has the LVIS_SELECTED state flag set.
			--
			-- Declared in Windows as LVNI_SELECTED

feature -- ImageList State

	Lvsil_normal: INTEGER is 0
			-- Indicates the normal image list, which contains 
			-- selected, nonselected, and overlay images for the
			-- items of a list view control.
			-- This image list represents the large icons.
			--
			-- Declared in Windows as LVSIL_NORMAL

	Lvsil_small: INTEGER is 1
			-- Indicates the normal image list, which contains 
			-- selected, nonselected, and overlay images for the
			-- items of a list view control.
			-- This image list represents the small icons.
			--
			-- Declared in Windows as LVSIL_SMALL

	Lvsil_state: INTEGER is 2
			-- Indicates the state image list. You can use state 
			-- images to indicate application-defined item states. 
			-- A state image is displayed to the left of an item's
			-- selected or nonselected image.
			--
			-- Declared in Windows as LVSIL_STATE

feature -- Flags defining search in a list view. 
		--| Used in WEL_LIST_VIEW_SEARCH_INFO

	Lvfi_param: INTEGER is 1
			-- Search item with corresponding lparam attribute
			--
			-- Declared in Windows as LVFI_PARAM

	Lvfi_partial: INTEGER is 8
			-- Search item including given string
			--
			-- Declared in Windows as LVFI_PARTIAL

	Lvfi_string: INTEGER is 2
			-- Search item with exact corresponding string
			--
			-- Declared in Windows as LVFI_STRING

	Lvfi_wrap: INTEGER is 32
			-- Start search from start when end of list view is reached
			--
			-- Declared in Windows as LVFI_WRAP

	Lvfi_nearestxy: INTEGER is 64
			-- Search item nearest specified position in specified direction
			--
			-- Declared in Windows as LVFI_NEARESTXY

feature -- List View Item Rectangle constants.

	Lvir_bounds: INTEGER is 0
			-- Returns the bounding rectangle of the entire item, including 
			-- the icon and label. 
			--
			-- Declared in Windows as LVIR_BOUNDS

	Lvir_icon: INTEGER is 1
			-- Returns the bounding rectangle of the icon or small icon. 
			--
			-- Declared in Windows as LVIR_ICON

	Lvir_label: INTEGER is 2
			-- Returns the bounding rectangle of the item text. 
			--
			-- Declared in Windows as LVIR_LABEL

	Lvir_selectbounds: INTEGER is 3
			-- Returns the union of the LVIR_ICON and LVIR_LABEL rectangles, 
			-- but excludes columns in report view. 
			--
			-- Declared in Windows as LVIR_SELECTBOUNDS

feature -- Validation

	is_valid_list_view_flag (a_flag: INTEGER): BOOLEAN is
			-- Is `a_flag' a valid list view search flag?
		do
			Result := a_flag = Lvfi_param or a_flag = Lvfi_partial
						or a_flag = Lvfi_string or a_flag = Lvfi_wrap
						or a_flag = Lvfi_nearestxy
		end
						
	valid_lvcfmt_constant (value: INTEGER): BOOLEAN is
			-- Is `value' a valid lvcfmt constant?
		do
			Result := value = Lvcfmt_left or else
				value = Lvcfmt_center or else
				value = Lvcfmt_right or else
				value = Lvcfmt_justifymask
		end

	valid_lvis_constants (value: INTEGER): BOOLEAN is
			-- Is `value' a valid "Item Styles" constant?
		do
			Result := value = Lvis_cut or else
				value = Lvis_drophilited or else
				value = Lvis_focused or else
				value = Lvis_selected
		end 

end -- class WEL_LIST_VIEW_CONSTANTS

--|-----------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--|-----------------------------------------------------------------------
