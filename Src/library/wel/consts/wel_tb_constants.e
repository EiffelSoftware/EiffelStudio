note
	description	: "Toolbar message (TB_...) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_TB_CONSTANTS

feature -- Access

	Tb_addbitmap: INTEGER = 1043
			-- Adds one or more images to the list of button images available
			-- for a toolbar.

	Tb_addbuttons: INTEGER = 1044
			-- Adds one or more buttons to a toolbar.

	Tb_addstring: INTEGER = 1101
			-- Adds a new string to the toolbar's string pool.
			-- (ANSI Version)

	Tb_autosize: INTEGER = 1057
			-- Causes a toolbar to be resized.

	Tb_buttoncount: INTEGER = 1048
			-- Retrieves a count of the buttons currently in the toolbar.

	Tb_buttonstructsize: INTEGER = 1054
			-- Specifies the size of the TBBUTTON structure.

	Tb_changebitmap: INTEGER = 1067
			-- Changes the bitmap for a button in a toolbar.

	Tb_checkbutton: INTEGER = 1026
			-- Checks or unchecks a given button in a toolbar.

	Tb_commandtoindex: INTEGER = 1049
			-- Retrieves the zero-based index for the button associated with the
			-- specified command identifier.

	Tb_customize: INTEGER = 1051
			-- Displays the Customize Toolbar dialog box.

	Tb_deletebutton: INTEGER = 1046
			-- Deletes a button from the toolbar.

	Tb_enablebutton: INTEGER = 1025
			-- Enables or disables the specified button in a toolbar.

	Tb_getbitmap: INTEGER = 1068
			-- Retrieves the index of the bitmap associated with a button
			-- in a toolbar.

	Tb_getbitmapflags: INTEGER = 1065
			-- Retrieves the flags that describe the type of bitmap to be used.

	Tb_getbutton: INTEGER = 1047
			-- Retrieves information about the specified button in a toolbar.

	Tb_getbuttontext: INTEGER = 1099
			-- Retrieves the display text of a button on a toolbar.

	Tb_getitemrect: INTEGER = 1053
			-- Retrieves the bounding rectangle of a button in a toolbar.

	Tb_getrows: INTEGER = 1064
			-- Retrieves the number of rows of buttons in a toolbar with the
			-- TBSTYLE_WRAPABLE style.

	Tb_getstate: INTEGER = 1042
			-- Retrieves information about the state of the specified button
			-- in a toolbar, such as whether it is enabled, pressed, or checked.

	Tb_gettooltips: INTEGER = 1059
			-- Retrieves the handle to the tooltip control, if any, associated
			-- with the toolbar.

	Tb_hidebutton: INTEGER = 1028
			-- Hides or shows the specified button in a toolbar.

	Tb_hittest: INTEGER = 1093
			-- Determines where a point lies in a toolbar control.

	Tb_setdrawtextflags: INTEGER = 1094
			-- Sets the text drawing flags for the toolbar.

	Tb_indeterminate: INTEGER = 1029
			-- Sets or clears the indeterminate state of the specified button
			-- in a toolbar.

	Tb_insertbutton: INTEGER = 1045
			-- Inserts a button in a toolbar.

	Tb_isbuttonchecked: INTEGER = 1034
			-- Determines whether the specified button in a toolbar is checked.

	Tb_isbuttonenabled: INTEGER = 1033
			-- Determines whether the specified button in a toolbar is enabled.

	Tb_isbuttonhidden: INTEGER = 1036
			-- Determines whether the specified button in a toolbar is hidden.

	Tb_isbuttonindeterminate: INTEGER = 1037
			-- Determines whether the specified button in a toolbar is indeterminate.

	Tb_isbuttonpressed: INTEGER = 1035
			-- Determines whether the specified button in a toolbar is pressed.

	Tb_pressbutton: INTEGER = 1027
			-- Presses or releases the specified button in a toolbar.

	Tb_saverestore: INTEGER = 1100
			-- Send this message to initiate saving or restoring a toolbar state.

	Tb_setbitmapsize: INTEGER = 1056
			-- Sets the size of the bitmapped images to be added to a toolbar.

	Tb_setbuttonsize: INTEGER = 1055
			-- Sets the size of the buttons to be added to a toolbar.

	Tb_setcmdid: INTEGER = 1066
			-- Sets the command identifier of a toolbar button.

	Tb_setparent: INTEGER = 1061
			-- Sets the window to which the toolbar control sends notification messages.

	Tb_setrows: INTEGER = 1063
			-- Sets the number of rows of buttons in a toolbar.

	Tb_setstate: INTEGER = 1041
			-- Sets the state for the specified button in a toolbar.

	Tb_settooltips: INTEGER = 1060
			-- Associates a tooltip control with a toolbar.


feature -- Access Comctl32.dll >= 4.70 (Windows95 + IE4 and above)

	Tb_setindent: INTEGER = 1071
			-- Sets the indentation for the first button in a toolbar control

	Tb_setimagelist: INTEGER = 1072
			-- Set the image list that the toolbar will use
			-- to display buttons that are in their default state.

	Tb_getimagelist: INTEGER = 1073
			-- Retrieves the image list that a toolbar control uses to display
			-- buttons in their default state. A toolbar control uses this
			-- image list to display buttons when they are not hot or disabled

	Tb_loadimages: INTEGER = 1074
			-- Loads bitmaps into a toolbar control's image list.

	Tb_getrect: INTEGER = 1075
			-- Retrieves the bounding rectangle for a specified toolbar button

	Tb_sethotimagelist: INTEGER = 1076
			-- Sets the image list that the toolbar control will use to
			-- display hot buttons.

	Tb_gethotimagelist: INTEGER = 1077
			-- Retrieves the image list that a toolbar control uses to display
			-- hot buttons.

	Tb_setdisabledimagelist: INTEGER = 1078
			-- Sets the image list that the toolbar control will use to display
			-- disabled buttons.

	Tb_getdisabledimagelist: INTEGER = 1079
			-- Retrieves the image list that a toolbar control uses to display
			-- disabled buttons.

	Tb_setstyle: INTEGER = 1080
			-- Sets the style for a toolbar control.

	Tb_getstyle: INTEGER = 1081
			-- Retrieves the styles currently in use for a toolbar control.

	Tb_getbuttonsize: INTEGER = 1082
			-- Retrieves the current width and height of toolbar buttons, in
			-- pixels.

	Tb_setbuttonwidth: INTEGER = 1083
			-- Sets the minimum and maximum button widths in the toolbar
			-- control.

	Tb_setmaxtextrows: INTEGER = 1084
			-- Sets the maximum number of text rows displayed on a toolbar
			-- button.

	Tb_gettextrows: INTEGER = 1085
			-- Retrieves the maximum number of text rows that can be
			-- displayed on a toolbar button.


feature -- Access Comctl32.dll >= 4.71 (Windows95 + IE4 and above)

	Tb_getobject: INTEGER = 1086
		-- Retrieves the IDropTarget for a toolbar control.

	Tb_gethotitem: INTEGER = 1095
		-- Retrieves the index of the hot item in a toolbar.

	Tb_sethotitem: INTEGER = 1096
		-- Sets the hot item in a toolbar.
		-- This message is ignored for toolbar controls that do not have the
		-- TBSTYLE_FLAT style.

	Tb_setanchorhighlight: INTEGER = 1097
		-- Sets the anchor highlight setting for a toolbar.

	Tb_getanchorhighlight: INTEGER = 1098
		-- Retrieves the anchor highlight setting for a toolbar.

	Tb_getinsertmark: INTEGER = 1103
		-- Retrieves the current insertion mark for the toolbar.

	Tb_setinsertmark: INTEGER = 1104
		-- Sets the current insertion mark for the toolbar.

	Tb_insertmarkhittest: INTEGER = 1105
		-- Retrieves the insertion mark information for a point in a toolbar.

	Tb_movebutton: INTEGER = 1106
		-- Moves a button from one index to another.

	Tb_getmaxsize: INTEGER = 1107
		-- Retrieves the total size of all of the visible buttons and separators in the toolbar.

	Tb_setextendedstyle: INTEGER = 1108
		-- Sets the extended styles for a toolbar control.

	Tb_getextendedstyle: INTEGER = 1109
		-- Retrieves the extended styles for a toolbar control.

	Tb_getpadding: INTEGER = 1110
		-- Retrieves the padding for a toolbar control.

	Tb_setpadding: INTEGER = 1111
		-- Sets the padding for a toolbar control.

	Tb_setinsertmarkcolor: INTEGER = 1112
		-- Sets the color used to draw the insertion mark for the toolbar.

	Tb_getinsertmarkcolor: INTEGER = 1113;
		-- Retrieves the color used to draw the insertion mark for the toolbar.

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




end -- class WEL_TB_CONSTANTS

