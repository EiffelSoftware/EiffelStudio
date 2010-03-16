note

	description: 
		"Vendor Shell resources."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_VENDOR_SHELL_RESOURCES

feature -- Implementation

	XmNaudibleWarning: POINTER
			-- Core resource
		external
			"C [macro <Xm/VendorS.h>]: EIF_POINTER"
		alias
			"XmNaudibleWarning"
		end;

	XmNbuttonFontList: POINTER
			-- Core resource
		external
			"C [macro <Xm/VendorS.h>]: EIF_POINTER"
		alias
			"XmNbuttonFontList"
		end;

	XmNdefaultFontList: POINTER
			-- Core resource
		external
			"C [macro <Xm/VendorS.h>]: EIF_POINTER"
		alias
			"XmNdefaultFontList"
		end;

	XmNdeleteResponse: POINTER
			-- Core resource
		external
			"C [macro <Xm/VendorS.h>]: EIF_POINTER"
		alias
			"XmNdeleteResponse"
		end;

	XmNinputMethod: POINTER
			-- Core resource
		external
			"C [macro <Xm/VendorS.h>]: EIF_POINTER"
		alias
			"XmNinputMethod"
		end;

	XmNkeyboardFocusPolicy: POINTER
			-- Core resource
		external
			"C [macro <Xm/VendorS.h>]: EIF_POINTER"
		alias
			"XmNkeyboardFocusPolicy"
		end;

	XmNlabelFontList: POINTER
			-- Core resource
		external
			"C [macro <Xm/VendorS.h>]: EIF_POINTER"
		alias
			"XmNlabelFontList"
		end;

	XmNmwmDecorations: POINTER
			-- Core resource
		external
			"C [macro <Xm/VendorS.h>]: EIF_POINTER"
		alias
			"XmNmwmDecorations"
		end;

	XmNmwmFunctions: POINTER
			-- Core resource
		external
			"C [macro <Xm/VendorS.h>]: EIF_POINTER"
		alias
			"XmNmwmFunctions"
		end;

	XmNmwmInputMode: POINTER
			-- Core resource
		external
			"C [macro <Xm/VendorS.h>]: EIF_POINTER"
		alias
			"XmNmwmInputMode"
		end;

	XmNmwmMenu: POINTER
			-- Core resource
		external
			"C [macro <Xm/VendorS.h>]: EIF_POINTER"
		alias
			"XmNmwmMenu"
		end;

	XmNpreeditType: POINTER
			-- Core resource
		external
			"C [macro <Xm/VendorS.h>]: EIF_POINTER"
		alias
			"XmNpreeditType"
		end;

	XmNshellUnitType: POINTER
			-- Core resource
		external
			"C [macro <Xm/VendorS.h>]: EIF_POINTER"
		alias
			"XmNshellUnitType"
		end;

	XmNtextFontList: POINTER
			-- Core resource
		external
			"C [macro <Xm/VendorS.h>]: EIF_POINTER"
		alias
			"XmNtextFontList"
		end;

	XmNuseAsyncGeometry: POINTER
			-- Core resource
		external
			"C [macro <Xm/VendorS.h>]: EIF_POINTER"
		alias
			"XmNuseAsyncGeometry"
		end;

	XmBELL: INTEGER
			-- Core constant value
		external
			"C [macro <Xm/VendorS.h>]: EIF_INTEGER"
		alias
			"XmBELL"
		end;

	XmNONE: INTEGER
			-- Core constant value
		external
			"C [macro <Xm/VendorS.h>]: EIF_INTEGER"
		alias
			"XmNONE"
		end;

	XmDESTROY: INTEGER
			-- Core constant value
		external
			"C [macro <Xm/VendorS.h>]: EIF_INTEGER"
		alias
			"XmDESTROY"
		end;

	XmUNMAP: INTEGER
			-- Core constant value
		external
			"C [macro <Xm/VendorS.h>]: EIF_INTEGER"
		alias
			"XmUNMAP"
		end;

	XmDO_NOTHING: INTEGER
			-- Core constant value
		external
			"C [macro <Xm/VendorS.h>]: EIF_INTEGER"
		alias
			"XmDO_NOTHING"
		end;

	XmEXPLICIT: INTEGER
			-- Core constant value
		external
			"C [macro <Xm/VendorS.h>]: EIF_INTEGER"
		alias
			"XmEXPLICIT"
		end;

	XmPOINTER: INTEGER
			-- Core constant value
		external
			"C [macro <Xm/VendorS.h>]: EIF_INTEGER"
		alias
			"XmPOINTER"
		end;

	MWM_DECOR_ALL: INTEGER
			-- Core constant value
		external
			"C [macro <Xm/MwmUtil.h>]: EIF_INTEGER | <Xm/Xm.h>"
		alias
			"MWM_DECOR_ALL"
		end;

	MWM_DECOR_BORDER: INTEGER
			-- Core constant value
		external
			"C [macro <Xm/MwmUtil.h>]: EIF_INTEGER | <Xm/Xm.h>"
		alias
			"MWM_DECOR_BORDER"
		end;

	MWM_DECOR_RESIZEH: INTEGER
			-- Core constant value
		external
			"C [macro <Xm/MwmUtil.h>]: EIF_INTEGER | <Xm/Xm.h>"
		alias
			"MWM_DECOR_RESIZEH"
		end;

	MWM_DECOR_TITLE: INTEGER
			-- Core constant value
		external
			"C [macro <Xm/MwmUtil.h>]: EIF_INTEGER | <Xm/Xm.h>"
		alias
			"MWM_DECOR_TITLE"
		end;

	MWM_DECOR_MENU: INTEGER
			-- Core constant value
		external
			"C [macro <Xm/MwmUtil.h>]: EIF_INTEGER | <Xm/Xm.h>"
		alias
			"MWM_DECOR_MENU"
		end;

	MWM_DECOR_MINIMIZE: INTEGER
			-- Core constant value
		external
			"C [macro <Xm/MwmUtil.h>]: EIF_INTEGER | <Xm/Xm.h>"
		alias
			"MWM_DECOR_MINIMIZE"
		end;

	MWM_DECOR_MAXIMIZE: INTEGER
			-- Core constant value
		external
			"C [macro <Xm/MwmUtil.h>]: EIF_INTEGER | <Xm/Xm.h>"
		alias
			"MWM_DECOR_MAXIMIZE"
		end;

	MWM_FUNC_ALL: INTEGER
			-- Core constant value
		external
			"C [macro <Xm/MwmUtil.h>]: EIF_INTEGER | <Xm/Xm.h>"
		alias
			"MWM_FUNC_ALL"
		end;

	MWM_FUNC_RESIZE: INTEGER
			-- Core constant value
		external
			"C [macro <Xm/MwmUtil.h>]: EIF_INTEGER | <Xm/Xm.h>"
		alias
			"MWM_FUNC_RESIZE"
		end;

	MWM_FUNC_MOVE: INTEGER
			-- Core constant value
		external
			"C [macro <Xm/MwmUtil.h>]: EIF_INTEGER | <Xm/Xm.h>"
		alias
			"MWM_FUNC_MOVE"
		end;

	MWM_FUNC_MINIMIZE: INTEGER
			-- Core constant value
		external
			"C [macro <Xm/MwmUtil.h>]: EIF_INTEGER | <Xm/Xm.h>"
		alias
			"MWM_FUNC_MINIMIZE"
		end;

	MWM_FUNC_MAXIMIZE: INTEGER
			-- Core constant value
		external
			"C [macro <Xm/MwmUtil.h>]: EIF_INTEGER | <Xm/Xm.h>"
		alias
			"MWM_FUNC_MAXIMIZE"
		end;

	MWM_FUNC_CLOSE: INTEGER
			-- Core constant value
		external
			"C [macro <Xm/MwmUtil.h>]: EIF_INTEGER | <Xm/Xm.h>"
		alias
			"MWM_FUNC_CLOSE"
		end;

	MWM_INPUT_APPLICATION_MODAL: INTEGER
			-- Core constant value
		external
			"C [macro <Xm/MwmUtil.h>]: EIF_INTEGER | <Xm/Xm.h>"
		alias
			"MWM_INPUT_APPLICATION_MODAL"
		end;

	MWM_INPUT_SYSTEM_MODAL: INTEGER
			-- Core constant value
		external
			"C [macro <Xm/MwmUtil.h>]: EIF_INTEGER | <Xm/Xm.h>"
		alias
			"MWM_INPUT_SYSTEM_MODAL"
		end;

	XmPIXELS: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/VendorS.h>] : EIF_INTEGER"
		alias
			"XmPIXELS"
		end;

	Xm100TH_MILLIMETERS: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/VendorS.h>] : EIF_INTEGER"
		alias
			"Xm100TH_MILLIMETERS"
		end;

	Xm1000TH_INCHES: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/VendorS.h>] : EIF_INTEGER"
		alias
			"Xm1000TH_INCHES"
		end;

	Xm100TH_POINTS: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/VendorS.h>] : EIF_INTEGER"
		alias
			"Xm100TH_POINTS"
		end;

	Xm100TH_FONT_UNITS: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/VendorS.h>] : EIF_INTEGER"
		alias
			"Xm100TH_FONT_UNITS"
		end;

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




end -- class MEL_VENDOR_SHELL_RESSOURCES_RESOURCES


