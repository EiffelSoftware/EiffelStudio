indexing
	description	: "Toolbar message (TB_...) constants."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	status		: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_TB_CONSTANTS

feature -- Access

	Tb_addbitmap: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TB_ADDBITMAP"
		end

	Tb_addbuttons: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TB_ADDBUTTONS"
		end

	Tb_addstring: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TB_ADDSTRING"
		end

	Tb_autosize: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TB_AUTOSIZE"
		end

	Tb_buttoncount: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TB_BUTTONCOUNT"
		end

	Tb_buttonstructsize: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TB_BUTTONSTRUCTSIZE"
		end

	Tb_changebitmap: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TB_CHANGEBITMAP"
		end

	Tb_checkbutton: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TB_CHECKBUTTON"
		end

	Tb_commandtoindex: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TB_COMMANDTOINDEX"
		end

	Tb_customize: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TB_CUSTOMIZE"
		end

	Tb_deletebutton: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TB_DELETEBUTTON"
		end

	Tb_enablebutton: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TB_ENABLEBUTTON"
		end

	Tb_getbitmap: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TB_GETBITMAP"
		end

	Tb_getbitmapflags: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TB_GETBITMAPFLAGS"
		end

	Tb_getbutton: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TB_GETBUTTON"
		end

	Tb_getbuttontext: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TB_GETBUTTONTEXT"
		end

	Tb_getitemrect: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TB_GETITEMRECT"
		end

	Tb_getrows: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TB_GETROWS"
		end

	Tb_getstate: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TB_GETSTATE"
		end

	Tb_gettooltips: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TB_GETTOOLTIPS"
		end

	Tb_hidebutton: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TB_HIDEBUTTON"
		end

	Tb_hittest: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TB_HITTEST"
		end

	Tb_indeterminate: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TB_INDETERMINATE"
		end

	Tb_insertbutton: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TB_INSERTBUTTON"
		end

	Tb_isbuttonchecked: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TB_ISBUTTONCHECKED"
		end

	Tb_isbuttonenabled: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TB_ISBUTTONENABLED"
		end

	Tb_isbuttonhidden: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TB_ISBUTTONHIDDEN"
		end

	Tb_isbuttonindeterminate: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TB_ISBUTTONINDETERMINATE"
		end

	Tb_isbuttonpressed: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TB_ISBUTTONPRESSED"
		end

	Tb_pressbutton: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TB_PRESSBUTTON"
		end

	Tb_saverestore: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TB_SAVERESTORE"
		end

	Tb_setbitmapsize: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TB_SETBITMAPSIZE"
		end

	Tb_setbuttonsize: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TB_SETBUTTONSIZE"
		end

	Tb_setcmdid: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TB_SETCMDID"
		end

	Tb_setparent: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TB_SETPARENT"
		end

	Tb_setrows: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TB_SETROWS"
		end

	Tb_setstate: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TB_SETSTATE"
		end

	Tb_settooltips: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TB_SETTOOLTIPS"
		end

feature -- Access Comctl32.dll >= 4.70 (Windows95 + IE4 and above)

	--|------------------------------------------------------|
	--| Note, Arnaud PICHERY [ aranud@mail.dotcom.fr ]       |
	--|------------------------------------------------------|
	--| The following constants are not declared as usual    |
	--| to allow Win95 users to compile without getting an   |
	--| Error during C compilation because TB_XXX is not     |
	--| defined...                                           |
	--|------------------------------------------------------|

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

