indexing
    description:
        "Resource values for KEYSYM definition. Only includes latin 1 %
		%and common keysym definitions.";
    status: "See notice at end of class";
    date: "$Date$";
    revision: "$Revision$"

class MEL_KEYSYMDEF_CONSTANTS

feature -- keysymdef resources

	XK_BackSpace: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_BackSpace"
		end
	
	XK_Tab: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Tab"
		end
	
	XK_Linefeed: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Linefeed"
		end
	
	XK_Clear: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Clear"
		end
	
	XK_Return: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Return"
		end
	
	XK_Pause: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Pause"
		end
	
	XK_Scroll_Lock: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Scroll_Lock"
		end
	
	XK_Sys_Req: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Sys_Req"
		end
	
	XK_Escape: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Escape"
		end
	
	XK_Delete: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Delete"
		end
	
	XK_Home: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Home"
		end
	
	XK_Left: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Left"
		end
	
	XK_Up: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Up"
		end
	
	XK_Right: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Right"
		end
	
	XK_Down: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Down"
		end
	
	XK_Prior: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Prior"
		end
	
	XK_Page_Up: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Page_Up"
		end
	
	XK_Next: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Next"
		end
	
	XK_Page_Down: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Page_Down"
		end
	
	XK_End: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_End"
		end
	
	XK_Begin: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Begin"
		end
	
	XK_Select: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Select"
		end
	
	XK_Print: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Print"
		end
	
	XK_Execute: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Execute"
		end
	
	XK_Insert: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Insert"
		end
	
	XK_Undo: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Undo"
		end
	
	XK_Redo: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Redo"
		end
	
	XK_Menu: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Menu"
		end
	
	XK_Find: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Find"
		end
	
	XK_Cancel: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Cancel"
		end
	
	XK_Help: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Help"
		end
	
	XK_Break: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Break"
		end
	
	XK_Mode_switch: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Mode_switch"
		end
	
	XK_script_switch: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_script_switch"
		end
	
	XK_Num_Lock: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Num_Lock"
		end
	
	XK_KP_Space: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_KP_Space"
		end
	
	XK_KP_Tab: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_KP_Tab"
		end
	
	XK_KP_Enter: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_KP_Enter"
		end
	
	XK_KP_F1: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_KP_F1"
		end
	
	XK_KP_F2: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_KP_F2"
		end
	
	XK_KP_F3: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_KP_F3"
		end
	
	XK_KP_F4: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_KP_F4"
		end
	
	XK_KP_Home: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_KP_Home"
		end
	
	XK_KP_Left: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_KP_Left"
		end
	
	XK_KP_Up: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_KP_Up"
		end
	
	XK_KP_Right: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_KP_Right"
		end
	
	XK_KP_Down: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_KP_Down"
		end
	
	XK_KP_Prior: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_KP_Prior"
		end
	
	XK_KP_Page_Up: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_KP_Page_Up"
		end
	
	XK_KP_Next: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_KP_Next"
		end
	
	XK_KP_Page_Down: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_KP_Page_Down"
		end
	
	XK_KP_End: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_KP_End"
		end
	
	XK_KP_Begin: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_KP_Begin"
		end
	
	XK_KP_Insert: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_KP_Insert"
		end
	
	XK_KP_Delete: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_KP_Delete"
		end
	
	XK_KP_Equal: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_KP_Equal"
		end
	
	XK_KP_Multiply: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_KP_Multiply"
		end
	
	XK_KP_Add: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_KP_Add"
		end
	
	XK_KP_Separator: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_KP_Separator"
		end
	
	XK_KP_Subtract: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_KP_Subtract"
		end
	
	XK_KP_Decimal: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_KP_Decimal"
		end
	
	XK_KP_Divide: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_KP_Divide"
		end
	
	XK_KP_0: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_KP_0"
		end
	
	XK_KP_1: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_KP_1"
		end
	
	XK_KP_2: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_KP_2"
		end
	
	XK_KP_3: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_KP_3"
		end
	
	XK_KP_4: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_KP_4"
		end
	
	XK_KP_5: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_KP_5"
		end
	
	XK_KP_6: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_KP_6"
		end
	
	XK_KP_7: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_KP_7"
		end
	
	XK_KP_8: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_KP_8"
		end
	
	XK_KP_9: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_KP_9"
		end
	
	XK_F1: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_F1"
		end
	
	XK_F2: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_F2"
		end
	
	XK_F3: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_F3"
		end
	
	XK_F4: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_F4"
		end
	
	XK_F5: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_F5"
		end
	
	XK_F6: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_F6"
		end
	
	XK_F7: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_F7"
		end
	
	XK_F8: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_F8"
		end
	
	XK_F9: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_F9"
		end
	
	XK_F10: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_F10"
		end
	
	XK_F11: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_F11"
		end
	
	XK_L1: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_L1"
		end
	
	XK_F12: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_F12"
		end
	
	XK_L2: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_L2"
		end
	
	XK_F13: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_F13"
		end
	
	XK_L3: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_L3"
		end
	
	XK_F14: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_F14"
		end
	
	XK_L4: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_L4"
		end
	
	XK_F15: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_F15"
		end
	
	XK_L5: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_L5"
		end
	
	XK_F16: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_F16"
		end
	
	XK_L6: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_L6"
		end
	
	XK_F17: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_F17"
		end
	
	XK_L7: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_L7"
		end
	
	XK_F18: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_F18"
		end
	
	XK_L8: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_L8"
		end
	
	XK_F19: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_F19"
		end
	
	XK_L9: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_L9"
		end
	
	XK_F20: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_F20"
		end
	
	XK_L10: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_L10"
		end
	
	XK_F21: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_F21"
		end
	
	XK_R1: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_R1"
		end
	
	XK_F22: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_F22"
		end
	
	XK_R2: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_R2"
		end
	
	XK_F23: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_F23"
		end
	
	XK_R3: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_R3"
		end
	
	XK_F24: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_F24"
		end
	
	XK_R4: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_R4"
		end
	
	XK_F25: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_F25"
		end
	
	XK_R5: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_R5"
		end
	
	XK_F26: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_F26"
		end
	
	XK_R6: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_R6"
		end
	
	XK_F27: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_F27"
		end
	
	XK_R7: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_R7"
		end
	
	XK_F28: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_F28"
		end
	
	XK_R8: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_R8"
		end
	
	XK_F29: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_F29"
		end
	
	XK_R9: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_R9"
		end
	
	XK_F30: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_F30"
		end
	
	XK_R10: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_R10"
		end
	
	XK_F31: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_F31"
		end
	
	XK_R11: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_R11"
		end
	
	XK_F32: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_F32"
		end
	
	XK_R12: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_R12"
		end
	
	XK_F33: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_F33"
		end
	
	XK_R13: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_R13"
		end
	
	XK_F34: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_F34"
		end
	
	XK_R14: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_R14"
		end
	
	XK_F35: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_F35"
		end
	
	XK_R15: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_R15"
		end
	
	XK_Shift_L: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Shift_L"
		end
	
	XK_Shift_R: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Shift_R"
		end
	
	XK_Control_L: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Control_L"
		end
	
	XK_Control_R: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Control_R"
		end
	
	XK_Caps_Lock: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Caps_Lock"
		end
	
	XK_Shift_Lock: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Shift_Lock"
		end
	
	XK_Meta_L: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Meta_L"
		end
	
	XK_Meta_R: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Meta_R"
		end
	
	XK_Alt_L: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Alt_L"
		end
	
	XK_Alt_R: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Alt_R"
		end
	
	XK_Super_L: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Super_L"
		end
	
	XK_Super_R: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Super_R"
		end
	
	XK_Hyper_R: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Hyper_R"
		end
	
	XK_Hyper_L: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Hyper_L"
		end
	
	XK_space: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_space"
		end
	
	XK_exclam: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_exclam"
		end
	
	XK_quotedbl: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_quotedbl"
		end
	
	XK_numbersign: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_numbersign"
		end
	
	XK_dollar: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_dollar"
		end
	
	XK_percent: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_percent"
		end
	
	XK_ampersand: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_ampersand"
		end
	
	XK_apostrophe: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_apostrophe"
		end
	
	XK_quoteright: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_quoteright"
		end
	
	XK_parenleft: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_parenleft"
		end
	
	XK_parenright: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_parenright"
		end
	
	XK_asterisk: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_asterisk"
		end
	
	XK_plus: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_plus"
		end
	
	XK_comma: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_comma"
		end
	
	XK_minus: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_minus"
		end
	
	XK_period: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_period"
		end
	
	XK_slash: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_slash"
		end
	
	XK_0: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_0"
		end
	
	XK_1: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_1"
		end
	
	XK_2: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_2"
		end
	
	XK_3: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_3"
		end
	
	XK_4: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_4"
		end
	
	XK_5: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_5"
		end
	
	XK_6: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_6"
		end
	
	XK_7: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_7"
		end
	
	XK_8: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_8"
		end
	
	XK_9: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_9"
		end
	
	XK_colon: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_colon"
		end
	
	XK_semicolon: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_semicolon"
		end
	
	XK_less: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_less"
		end
	
	XK_equal: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_equal"
		end
	
	XK_greater: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_greater"
		end
	
	XK_question: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_question"
		end
	
	XK_at: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_at"
		end
	
	XK_upper_A: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_A"
		end
	
	XK_upper_B: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_B"
		end
	
	XK_upper_C: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_C"
		end
	
	XK_upper_D: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_D"
		end
	
	XK_upper_E: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_E"
		end
	
	XK_upper_F: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_F"
		end
	
	XK_upper_G: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_G"
		end
	
	XK_upper_H: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_H"
		end
	
	XK_upper_I: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_I"
		end
	
	XK_upper_J: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_J"
		end
	
	XK_upper_K: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_K"
		end
	
	XK_upper_L: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_L"
		end
	
	XK_upper_M: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_M"
		end
	
	XK_upper_N: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_N"
		end
	
	XK_upper_O: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_O"
		end
	
	XK_upper_P: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_P"
		end
	
	XK_upper_Q: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Q"
		end
	
	XK_upper_R: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_R"
		end
	
	XK_upper_S: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_S"
		end
	
	XK_upper_T: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_T"
		end
	
	XK_upper_U: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_U"
		end
	
	XK_upper_V: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_V"
		end
	
	XK_upper_W: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_W"
		end
	
	XK_upper_X: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_X"
		end
	
	XK_upper_Y: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Y"
		end
	
	XK_upper_Z: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Z"
		end
	
	XK_bracketleft: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_bracketleft"
		end
	
	XK_backslash: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_backslash"
		end
	
	XK_bracketright: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_bracketright"
		end
	
	XK_asciicircum: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_asciicircum"
		end
	
	XK_underscore: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_underscore"
		end
	
	XK_grave: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_grave"
		end
	
	XK_quoteleft: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_quoteleft"
		end
	
	XK_a: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_a"
		end
	
	XK_b: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_b"
		end
	
	XK_c: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_c"
		end
	
	XK_d: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_d"
		end
	
	XK_e: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_e"
		end
	
	XK_f: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_f"
		end
	
	XK_g: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_g"
		end
	
	XK_h: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_h"
		end
	
	XK_i: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_i"
		end
	
	XK_j: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_j"
		end
	
	XK_k: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_k"
		end
	
	XK_l: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_l"
		end
	
	XK_m: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_m"
		end
	
	XK_n: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_n"
		end
	
	XK_o: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_o"
		end
	
	XK_p: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_p"
		end
	
	XK_q: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_q"
		end
	
	XK_r: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_r"
		end
	
	XK_s: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_s"
		end
	
	XK_t: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_t"
		end
	
	XK_u: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_u"
		end
	
	XK_v: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_v"
		end
	
	XK_w: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_w"
		end
	
	XK_x: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_x"
		end
	
	XK_y: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_y"
		end
	
	XK_z: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_z"
		end
	
	XK_braceleft: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_braceleft"
		end
	
	XK_bar: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_bar"
		end
	
	XK_braceright: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_braceright"
		end
	
	XK_asciitilde: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_asciitilde"
		end
	
	XK_nobreakspace: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_nobreakspace"
		end
	
	XK_exclamdown: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_exclamdown"
		end
	
	XK_cent: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_cent"
		end
	
	XK_sterling: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_sterling"
		end
	
	XK_currency: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_currency"
		end
	
	XK_yen: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_yen"
		end
	
	XK_brokenbar: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_brokenbar"
		end
	
	XK_section: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_section"
		end
	
	XK_diaeresis: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_diaeresis"
		end
	
	XK_copyright: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_copyright"
		end
	
	XK_ordfeminine: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_ordfeminine"
		end
	
	XK_guillemotleft: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_guillemotleft"
		end
	
	XK_notsign: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_notsign"
		end
	
	XK_hyphen: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_hyphen"
		end
	
	XK_registered: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_registered"
		end
	
	XK_macron: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_macron"
		end
	
	XK_degree: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_degree"
		end
	
	XK_plusminus: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_plusminus"
		end
	
	XK_twosuperior: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_twosuperior"
		end
	
	XK_threesuperior: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_threesuperior"
		end
	
	XK_acute: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_acute"
		end
	
	XK_mu: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_mu"
		end
	
	XK_paragraph: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_paragraph"
		end
	
	XK_periodcentered: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_periodcentered"
		end
	
	XK_cedilla: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_cedilla"
		end
	
	XK_onesuperior: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_onesuperior"
		end
	
	XK_masculine: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_masculine"
		end
	
	XK_guillemotright: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_guillemotright"
		end
	
	XK_onequarter: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_onequarter"
		end
	
	XK_onehalf: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_onehalf"
		end
	
	XK_threequarters: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_threequarters"
		end
	
	XK_questiondown: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_questiondown"
		end
	
	XK_Agrave: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Agrave"
		end
	
	XK_Aacute: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Aacute"
		end
	
	XK_Acircumflex: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Acircumflex"
		end
	
	XK_Atilde: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Atilde"
		end
	
	XK_Adiaeresis: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Adiaeresis"
		end
	
	XK_Aring: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Aring"
		end
	
	XK_AE: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_AE"
		end
	
	XK_Ccedilla: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Ccedilla"
		end
	
	XK_Egrave: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Egrave"
		end
	
	XK_Eacute: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Eacute"
		end
	
	XK_Ecircumflex: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Ecircumflex"
		end
	
	XK_Ediaeresis: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Ediaeresis"
		end
	
	XK_Igrave: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Igrave"
		end
	
	XK_Iacute: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Iacute"
		end
	
	XK_Icircumflex: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Icircumflex"
		end
	
	XK_Idiaeresis: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Idiaeresis"
		end

	XK_upper_ETH: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_ETH"
		end
	
	XK_upperE_Eth: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Eth"
		end
	
	XK_Ntilde: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Ntilde"
		end
	
	XK_Ograve: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Ograve"
		end
	
	XK_Oacute: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Oacute"
		end
	
	XK_Ocircumflex: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Ocircumflex"
		end
	
	XK_Otilde: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Otilde"
		end
	
	XK_Odiaeresis: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Odiaeresis"
		end
	
	XK_multiply: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_multiply"
		end
	
	XK_Ooblique: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Ooblique"
		end
	
	XK_Ugrave: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Ugrave"
		end
	
	XK_Uacute: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Uacute"
		end
	
	XK_Ucircumflex: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Ucircumflex"
		end
	
	XK_Udiaeresis: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Udiaeresis"
		end
	
	XK_Yacute: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Yacute"
		end
	
	XK_upper_THORN: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_THORN"
		end
	
	XK_Thorn: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_Thorn"
		end
	
	XK_ssharp: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_ssharp"
		end
	
	XK_lower_agrave: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_agrave"
		end
	
	XK_lower_aacute: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_aacute"
		end
	
	XK_lower_acircumflex: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_acircumflex"
		end
	
	XK_lower_atilde: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_atilde"
		end
	
	XK_lower_adiaeresis: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_adiaeresis"
		end
	
	XK_lower_aring: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_aring"
		end
	
	XK_lower_ae: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_ae"
		end
	
	XK_lower_ccedilla: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_ccedilla"
		end
	
	XK_lower_egrave: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_egrave"
		end
	
	XK_lower_eacute: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_eacute"
		end
	
	XK_lower_ecircumflex: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_ecircumflex"
		end
	
	XK_lower_ediaeresis: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_ediaeresis"
		end
	
	XK_lower_igrave: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_igrave"
		end
	
	XK_lower_iacute: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_iacute"
		end
	
	XK_lower_icircumflex: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_icircumflex"
		end
	
	XK_lower_idiaeresis: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_idiaeresis"
		end
	
	XK_lower_eth: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_eth"
		end
	
	XK_lower_ntilde: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_ntilde"
		end
	
	XK_lower_ograve: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_ograve"
		end
	
	XK_lower_oacute: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_oacute"
		end
	
	XK_lower_ocircumflex: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_ocircumflex"
		end
	
	XK_lower_otilde: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_otilde"
		end
	
	XK_lower_odiaeresis: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_odiaeresis"
		end
	
	XK_division: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_division"
		end
	
	XK_oslash: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_oslash"
		end
	
	XK_lower_ugrave: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_ugrave"
		end
	
	XK_lower_uacute: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_uacute"
		end
	
	XK_lower_ucircumflex: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_ucircumflex"
		end
	
	XK_lower_udiaeresis: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_udiaeresis"
		end
	
	XK_lower_yacute: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_yacute"
		end
	
	XK_lower_thorn: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_thorn"
		end
	
	XK_ydiaeresis: POINTER is
		external
			"C [macro <X11/keysymdef.h>] : EIF_POINTER%
				%| <X11/keysym.h>"
		alias
			"XK_ydiaeresis"
		end

end	-- class MEL_KEYSYMDEF_CONSTANTS

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------


--|-----------------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1996, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-----------------------------------------------------------------------
