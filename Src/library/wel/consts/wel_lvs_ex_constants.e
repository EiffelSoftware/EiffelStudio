indexing
	description	: "Extended list view styles (LVS_EX_...) constants."
	status		: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"
	
class
	WEL_LVS_EX_CONSTANTS

obsolete
	"use WEL_LIST_VIEW_CONSTANTS instead"

feature -- Access

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

end -- class WEL_LVS_EX_CONSTANTS

--|----------------------------------------------------------------
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
--|----------------------------------------------------------------

