indexing

	description: 
		"Manager resources.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_MANAGER_RESOURCES

feature  -- Implementation

	XmNbottomShadowColor: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNbottomShadowColor"
		end;

	XmNbottomShadowPixmap: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNbottomShadowPixmap"
		end;

	XmNforeground: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNforeground"
		end;

	XmNhighlightColor: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNhighlightColor"
		end;

	XmNhighlightPixmap: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNhighlightPixmap"
		end;

	XmNinitialFocus: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNinitialFocus"
		end;

	XmNnavigationType: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNnavigationType"
		end;

	XmNshadowThickness: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNshadowThickness"
		end;

	XmNstringDirection: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNstringDirection"
		end;

	XmNtopShadowColor: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNtopShadowColor"
		end;

	XmNtopShadowPixmap: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNtopShadowPixmap"
		end;

	XmNtraversalOn: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNtraversalOn"
		end;

	XmNunitType: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNunitType"
		end;

	XmNuserData: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNuserData"
		end;

	XmNhelpCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNhelpCallback"
		end;

	XmNONE: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Xm.h>] : EIF_INTEGER"
		alias
			"XmNONE"
		end;

	XmTAB_GROUP: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Xm.h>] : EIF_INTEGER"
		alias
			"XmTAB_GROUP"
		end;

	XmSTICKY_TAB_GROUP: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Xm.h>] : EIF_INTEGER"
		alias
			"XmSTICKY_TAB_GROUP"
		end;

	XmEXCLUSIVE_TAB_GROUP: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Xm.h>] : EIF_INTEGER"
		alias
			"XmEXCLUSIVE_TAB_GROUP"
		end;

	XmSTRING_DIRECTION_L_TO_R: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Xm.h>] : EIF_INTEGER"
		alias
			"XmSTRING_DIRECTION_L_TO_R"
		end;

	XmSTRING_DIRECTION_R_TO_L: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Xm.h>] : EIF_INTEGER"
		alias
			"XmSTRING_DIRECTION_R_TO_L"
		end;

	XmPIXELS: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Xm.h>] : EIF_INTEGER"
		alias
			"XmPIXELS"
		end;

	Xm100TH_MILLIMETERS: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Xm.h>] : EIF_INTEGER"
		alias
			"Xm100TH_MILLIMETERS"
		end;

	Xm1000TH_INCHES: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Xm.h>] : EIF_INTEGER"
		alias
			"Xm1000TH_INCHES"
		end;

	Xm100TH_POINTS: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Xm.h>] : EIF_INTEGER"
		alias
			"Xm100TH_POINTS"
		end;

	Xm100TH_FONT_UNITS: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Xm.h>] : EIF_INTEGER"
		alias
			"Xm100TH_FONT_UNITS"
		end;

end -- class MEL_MANAGER_RESOURCES



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

