indexing
	description	: "Toolbar message (TB_...) constants."
	status		: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_TB_CONSTANTS

feature -- Access

	Tb_addbitmap: INTEGER is 1043
			-- Adds one or more images to the list of button images available 
			-- for a toolbar. 

	Tb_addbuttons: INTEGER is 1044
			-- Adds one or more buttons to a toolbar.

	Tb_addstring: INTEGER is 1052
			-- Adds a new string to the toolbar's string pool.
			-- (ANSI Version)

	Tb_autosize: INTEGER is 1057
			-- Causes a toolbar to be resized. 

	Tb_buttoncount: INTEGER is 1048
			-- Retrieves a count of the buttons currently in the toolbar. 

	Tb_buttonstructsize: INTEGER is 1054
			-- Specifies the size of the TBBUTTON structure. 

	Tb_changebitmap: INTEGER is 1067
			-- Changes the bitmap for a button in a toolbar. 

	Tb_checkbutton: INTEGER is 1026
			-- Checks or unchecks a given button in a toolbar. 

	Tb_commandtoindex: INTEGER is 1049
			-- Retrieves the zero-based index for the button associated with the 
			-- specified command identifier. 

	Tb_customize: INTEGER is 1051
			-- Displays the Customize Toolbar dialog box. 

	Tb_deletebutton: INTEGER is 1046
			-- Deletes a button from the toolbar. 

	Tb_enablebutton: INTEGER is 1025
			-- Enables or disables the specified button in a toolbar. 

	Tb_getbitmap: INTEGER is 1068
			-- Retrieves the index of the bitmap associated with a button
			-- in a toolbar. 

	Tb_getbitmapflags: INTEGER is 1065
			-- Retrieves the flags that describe the type of bitmap to be used.

	Tb_getbutton: INTEGER is 1047
			-- Retrieves information about the specified button in a toolbar.

	Tb_getbuttontext: INTEGER is 1069
			-- Retrieves the display text of a button on a toolbar.

	Tb_getitemrect: INTEGER is 1053
			-- Retrieves the bounding rectangle of a button in a toolbar. 

	Tb_getrows: INTEGER is 1064
			-- Retrieves the number of rows of buttons in a toolbar with the 
			-- TBSTYLE_WRAPABLE style. 

	Tb_getstate: INTEGER is 1042
			-- Retrieves information about the state of the specified button 
			-- in a toolbar, such as whether it is enabled, pressed, or checked. 

	Tb_gettooltips: INTEGER is 1059
			-- Retrieves the handle to the tooltip control, if any, associated 
			-- with the toolbar. 

	Tb_hidebutton: INTEGER is 1028
			-- Hides or shows the specified button in a toolbar. 

	Tb_hittest: INTEGER is 1093
			-- Determines where a point lies in a toolbar control. 

	Tb_indeterminate: INTEGER is 1029
			-- Sets or clears the indeterminate state of the specified button 
			-- in a toolbar. 

	Tb_insertbutton: INTEGER is 1045
			-- Inserts a button in a toolbar.

	Tb_isbuttonchecked: INTEGER is 1034
			-- Determines whether the specified button in a toolbar is checked. 

	Tb_isbuttonenabled: INTEGER is 1033
			-- Determines whether the specified button in a toolbar is enabled. 

	Tb_isbuttonhidden: INTEGER is 1036
			-- Determines whether the specified button in a toolbar is hidden. 

	Tb_isbuttonindeterminate: INTEGER is 1037
			-- Determines whether the specified button in a toolbar is indeterminate. 

	Tb_isbuttonpressed: INTEGER is 1035
			-- Determines whether the specified button in a toolbar is pressed. 

	Tb_pressbutton: INTEGER is 1027
			-- Presses or releases the specified button in a toolbar. 

	Tb_saverestore: INTEGER is 1050
			-- Send this message to initiate saving or restoring a toolbar state.

	Tb_setbitmapsize: INTEGER is 1056
			-- Sets the size of the bitmapped images to be added to a toolbar. 

	Tb_setbuttonsize: INTEGER is 1055
			-- Sets the size of the buttons to be added to a toolbar. 

	Tb_setcmdid: INTEGER is 1066
			-- Sets the command identifier of a toolbar button. 

	Tb_setparent: INTEGER is 1061
			-- Sets the window to which the toolbar control sends notification messages. 

	Tb_setrows: INTEGER is 1063
			-- Sets the number of rows of buttons in a toolbar. 

	Tb_setstate: INTEGER is 1041
			-- Sets the state for the specified button in a toolbar. 

	Tb_settooltips: INTEGER is 1060
			-- Associates a tooltip control with a toolbar. 


feature -- Access Comctl32.dll >= 4.70 (Windows95 + IE4 and above)

	Tb_setindent: INTEGER is 1071
			-- Sets the indentation for the first button in a toolbar control

	Tb_setimagelist: INTEGER is 1072
			-- Set the image list that the toolbar will use 
			-- to display buttons that are in their default state.

	Tb_getimagelist: INTEGER is 1073
			-- Retrieves the image list that a toolbar control uses to display
			-- buttons in their default state. A toolbar control uses this
			-- image list to display buttons when they are not hot or disabled

	Tb_loadimages: INTEGER is 1074
			-- Loads bitmaps into a toolbar control's image list. 

	Tb_getrect: INTEGER is 1075
			-- Retrieves the bounding rectangle for a specified toolbar button

	Tb_sethotimagelist: INTEGER is 1076
			-- Sets the image list that the toolbar control will use to
			-- display hot buttons.

	Tb_gethotimagelist: INTEGER is 1077
			-- Retrieves the image list that a toolbar control uses to display
			-- hot buttons.

	Tb_setdisabledimagelist: INTEGER is 1078
			-- Sets the image list that the toolbar control will use to display
			-- disabled buttons.

	Tb_getdisabledimagelist: INTEGER is 1079
			-- Retrieves the image list that a toolbar control uses to display
			-- disabled buttons.

	Tb_setstyle: INTEGER is 1080
			-- Sets the style for a toolbar control.

	Tb_getstyle: INTEGER is 1081
			-- Retrieves the styles currently in use for a toolbar control.

	Tb_getbuttonsize: INTEGER is 1082
			-- Retrieves the current width and height of toolbar buttons, in
			-- pixels.

	Tb_setbuttonwidth: INTEGER is 1083
			-- Sets the minimum and maximum button widths in the toolbar
			-- control.

	Tb_setmaxtextrows: INTEGER is 1084
			-- Sets the maximum number of text rows displayed on a toolbar 
			-- button.

	Tb_gettextrows: INTEGER is 1085
			-- Retrieves the maximum number of text rows that can be
			-- displayed on a toolbar button.


feature -- Access Comctl32.dll >= 4.71 (Windows95 + IE4 and above)

	Tb_getobject: INTEGER is 1086
		-- Retrieves the IDropTarget for a toolbar control. 

	Tb_gethotitem: INTEGER is 1095
		-- Retrieves the index of the hot item in a toolbar. 

	Tb_sethotitem: INTEGER is 1096
		-- Sets the hot item in a toolbar. 
		-- This message is ignored for toolbar controls that do not have the
		-- TBSTYLE_FLAT style. 

	Tb_setanchorhighlight: INTEGER is 1097
		-- Sets the anchor highlight setting for a toolbar. 

	Tb_getanchorhighlight: INTEGER is 1098
		-- Retrieves the anchor highlight setting for a toolbar. 

	Tb_getinsertmark: INTEGER is 1103
		-- Retrieves the current insertion mark for the toolbar. 

	Tb_setinsertmark: INTEGER is 1104
		-- Sets the current insertion mark for the toolbar. 

	Tb_insertmarkhittest: INTEGER is 1105
		-- Retrieves the insertion mark information for a point in a toolbar.

	Tb_movebutton: INTEGER is 1106
		-- Moves a button from one index to another. 

	Tb_getmaxsize: INTEGER is 1107
		-- Retrieves the total size of all of the visible buttons and separators in the toolbar. 

	Tb_setextendedstyle: INTEGER is 1108
		-- Sets the extended styles for a toolbar control. 

	Tb_getextendedstyle: INTEGER is 1109
		-- Retrieves the extended styles for a toolbar control. 

	Tb_getpadding: INTEGER is 1110
		-- Retrieves the padding for a toolbar control. 

	Tb_setpadding: INTEGER is 1111
		-- Sets the padding for a toolbar control. 

	Tb_setinsertmarkcolor: INTEGER is 1112
		-- Sets the color used to draw the insertion mark for the toolbar. 

	Tb_getinsertmarkcolor: INTEGER is 1113
		-- Retrieves the color used to draw the insertion mark for the toolbar. 

end -- class WEL_TB_CONSTANTS


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

