indexing

	description: 
		"Vendor Shell resources.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_VENDOR_SHELL_RESOURCES

feature -- Implementation

	XmNaudibleWarning: POINTER is
			-- Core resource
		external
			"C [macro <Xm/VendorS.h>]: EIF_POINTER"
		alias
			"XmNaudibleWarning"
		end;

	XmNbuttonFontList: POINTER is
			-- Core resource
		external
			"C [macro <Xm/VendorS.h>]: EIF_POINTER"
		alias
			"XmNbuttonFontList"
		end;

	XmNdefaultFontList: POINTER is
			-- Core resource
		external
			"C [macro <Xm/VendorS.h>]: EIF_POINTER"
		alias
			"XmNdefaultFontList"
		end;

	XmNdeleteResponse: POINTER is
			-- Core resource
		external
			"C [macro <Xm/VendorS.h>]: EIF_POINTER"
		alias
			"XmNdeleteResponse"
		end;

	XmNinputMethod: POINTER is
			-- Core resource
		external
			"C [macro <Xm/VendorS.h>]: EIF_POINTER"
		alias
			"XmNinputMethod"
		end;

	XmNkeyboardFocusPolicy: POINTER is
			-- Core resource
		external
			"C [macro <Xm/VendorS.h>]: EIF_POINTER"
		alias
			"XmNkeyboardFocusPolicy"
		end;

	XmNlabelFontList: POINTER is
			-- Core resource
		external
			"C [macro <Xm/VendorS.h>]: EIF_POINTER"
		alias
			"XmNlabelFontList"
		end;

	XmNmwmDecorations: POINTER is
			-- Core resource
		external
			"C [macro <Xm/VendorS.h>]: EIF_POINTER"
		alias
			"XmNmwmDecorations"
		end;

	XmNmwmFunctions: POINTER is
			-- Core resource
		external
			"C [macro <Xm/VendorS.h>]: EIF_POINTER"
		alias
			"XmNmwmFunctions"
		end;

	XmNmwmInputMode: POINTER is
			-- Core resource
		external
			"C [macro <Xm/VendorS.h>]: EIF_POINTER"
		alias
			"XmNmwmInputMode"
		end;

	XmNmwmMenu: POINTER is
			-- Core resource
		external
			"C [macro <Xm/VendorS.h>]: EIF_POINTER"
		alias
			"XmNmwmMenu"
		end;

	XmNpreeditType: POINTER is
			-- Core resource
		external
			"C [macro <Xm/VendorS.h>]: EIF_POINTER"
		alias
			"XmNpreeditType"
		end;

	XmNshellUnitType: POINTER is
			-- Core resource
		external
			"C [macro <Xm/VendorS.h>]: EIF_POINTER"
		alias
			"XmNshellUnitType"
		end;

	XmNtextFontList: POINTER is
			-- Core resource
		external
			"C [macro <Xm/VendorS.h>]: EIF_POINTER"
		alias
			"XmNtextFontList"
		end;

	XmNuseAsyncGeometry: POINTER is
			-- Core resource
		external
			"C [macro <Xm/VendorS.h>]: EIF_POINTER"
		alias
			"XmNuseAsyncGeometry"
		end;

	XmBELL: INTEGER is
			-- Core constant value
		external
			"C [macro <Xm/VendorS.h>]: EIF_INTEGER"
		alias
			"XmBELL"
		end;

	XmNONE: INTEGER is
			-- Core constant value
		external
			"C [macro <Xm/VendorS.h>]: EIF_INTEGER"
		alias
			"XmNONE"
		end;

	XmDESTROY: INTEGER is
			-- Core constant value
		external
			"C [macro <Xm/VendorS.h>]: EIF_INTEGER"
		alias
			"XmDESTROY"
		end;

	XmUNMAP: INTEGER is
			-- Core constant value
		external
			"C [macro <Xm/VendorS.h>]: EIF_INTEGER"
		alias
			"XmUNMAP"
		end;

	XmDO_NOTHING: INTEGER is
			-- Core constant value
		external
			"C [macro <Xm/VendorS.h>]: EIF_INTEGER"
		alias
			"XmDO_NOTHING"
		end;

	XmEXPLICIT: INTEGER is
			-- Core constant value
		external
			"C [macro <Xm/VendorS.h>]: EIF_INTEGER"
		alias
			"XmEXPLICIT"
		end;

	XmPOINTER: INTEGER is
			-- Core constant value
		external
			"C [macro <Xm/VendorS.h>]: EIF_INTEGER"
		alias
			"XmPOINTER"
		end;

	MWM_DECOR_ALL: INTEGER is
			-- Core constant value
		external
			"C [macro <Xm/MwmUtil.h>]: EIF_INTEGER | <Xm/Xm.h>"
		alias
			"MWM_DECOR_ALL"
		end;

	MWM_DECOR_BORDER: INTEGER is
			-- Core constant value
		external
			"C [macro <Xm/MwmUtil.h>]: EIF_INTEGER | <Xm/Xm.h>"
		alias
			"MWM_DECOR_BORDER"
		end;

	MWM_DECOR_RESIZEH: INTEGER is
			-- Core constant value
		external
			"C [macro <Xm/MwmUtil.h>]: EIF_INTEGER | <Xm/Xm.h>"
		alias
			"MWM_DECOR_RESIZEH"
		end;

	MWM_DECOR_TITLE: INTEGER is
			-- Core constant value
		external
			"C [macro <Xm/MwmUtil.h>]: EIF_INTEGER | <Xm/Xm.h>"
		alias
			"MWM_DECOR_TITLE"
		end;

	MWM_DECOR_MENU: INTEGER is
			-- Core constant value
		external
			"C [macro <Xm/MwmUtil.h>]: EIF_INTEGER | <Xm/Xm.h>"
		alias
			"MWM_DECOR_MENU"
		end;

	MWM_DECOR_MINIMIZE: INTEGER is
			-- Core constant value
		external
			"C [macro <Xm/MwmUtil.h>]: EIF_INTEGER | <Xm/Xm.h>"
		alias
			"MWM_DECOR_MINIMIZE"
		end;

	MWM_DECOR_MAXIMIZE: INTEGER is
			-- Core constant value
		external
			"C [macro <Xm/MwmUtil.h>]: EIF_INTEGER | <Xm/Xm.h>"
		alias
			"MWM_DECOR_MAXIMIZE"
		end;

	MWM_FUNC_ALL: INTEGER is
			-- Core constant value
		external
			"C [macro <Xm/MwmUtil.h>]: EIF_INTEGER | <Xm/Xm.h>"
		alias
			"MWM_FUNC_ALL"
		end;

	MWM_FUNC_RESIZE: INTEGER is
			-- Core constant value
		external
			"C [macro <Xm/MwmUtil.h>]: EIF_INTEGER | <Xm/Xm.h>"
		alias
			"MWM_FUNC_RESIZE"
		end;

	MWM_FUNC_MOVE: INTEGER is
			-- Core constant value
		external
			"C [macro <Xm/MwmUtil.h>]: EIF_INTEGER | <Xm/Xm.h>"
		alias
			"MWM_FUNC_MOVE"
		end;

	MWM_FUNC_MINIMIZE: INTEGER is
			-- Core constant value
		external
			"C [macro <Xm/MwmUtil.h>]: EIF_INTEGER | <Xm/Xm.h>"
		alias
			"MWM_FUNC_MINIMIZE"
		end;

	MWM_FUNC_MAXIMIZE: INTEGER is
			-- Core constant value
		external
			"C [macro <Xm/MwmUtil.h>]: EIF_INTEGER | <Xm/Xm.h>"
		alias
			"MWM_FUNC_MAXIMIZE"
		end;

	MWM_FUNC_CLOSE: INTEGER is
			-- Core constant value
		external
			"C [macro <Xm/MwmUtil.h>]: EIF_INTEGER | <Xm/Xm.h>"
		alias
			"MWM_FUNC_CLOSE"
		end;

	MWM_INPUT_APPLICATION_MODAL: INTEGER is
			-- Core constant value
		external
			"C [macro <Xm/MwmUtil.h>]: EIF_INTEGER | <Xm/Xm.h>"
		alias
			"MWM_INPUT_APPLICATION_MODAL"
		end;

	MWM_INPUT_SYSTEM_MODAL: INTEGER is
			-- Core constant value
		external
			"C [macro <Xm/MwmUtil.h>]: EIF_INTEGER | <Xm/Xm.h>"
		alias
			"MWM_INPUT_SYSTEM_MODAL"
		end;

	XmPIXELS: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/VendorS.h>] : EIF_INTEGER"
		alias
			"XmPIXELS"
		end;

	Xm100TH_MILLIMETERS: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/VendorS.h>] : EIF_INTEGER"
		alias
			"Xm100TH_MILLIMETERS"
		end;

	Xm1000TH_INCHES: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/VendorS.h>] : EIF_INTEGER"
		alias
			"Xm1000TH_INCHES"
		end;

	Xm100TH_POINTS: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/VendorS.h>] : EIF_INTEGER"
		alias
			"Xm100TH_POINTS"
		end;

	Xm100TH_FONT_UNITS: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/VendorS.h>] : EIF_INTEGER"
		alias
			"Xm100TH_FONT_UNITS"
		end;

end -- class MEL_VENDOR_SHELL_RESSOURCES_RESOURCES


--|----------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel.
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

