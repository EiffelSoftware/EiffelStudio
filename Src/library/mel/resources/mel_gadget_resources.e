indexing

	description: 
		"Gadget resources.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_GADGET_RESOURCES

feature -- Implementation

	XmNbottomShadowColor: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNbottomShadowColor"
		end;	

	XmNhighlightColor: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNhighlightColor"
		end;	

	XmNhighlightOnEnter: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNhighlightOnEnter"
		end;	

	XmNhighlightThickness: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNhighlightThickness"
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

end -- class MEL_GADGET_RESOURCES

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
