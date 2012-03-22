note

	description: 
		"Gadget resources."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_GADGET_RESOURCES

feature -- Implementation

	XmNbottomShadowColor: POINTER
			-- Motif resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNbottomShadowColor"
		end;	

	XmNhighlightColor: POINTER
			-- Motif resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNhighlightColor"
		end;	

	XmNhighlightOnEnter: POINTER
			-- Motif resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNhighlightOnEnter"
		end;	

	XmNhighlightThickness: POINTER
			-- Motif resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNhighlightThickness"
		end;	

	XmNnavigationType: POINTER
			-- Motif resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNnavigationType"
		end;	

	XmNshadowThickness: POINTER
			-- Motif resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNshadowThickness"
		end;	

	XmNtopShadowColor: POINTER
			-- Motif resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNtopShadowColor"
		end;	

	XmNtopShadowPixmap: POINTER
			-- Motif resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNtopShadowPixmap"
		end;	

	XmNtraversalOn: POINTER
			-- Motif resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNtraversalOn"
		end;	

	XmNunitType: POINTER
			-- Motif resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNunitType"
		end;	

	XmNuserData: POINTER
			-- Motif resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNuserData"
		end;	

	XmNhelpCallback: POINTER
			-- Motif resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNhelpCallback"
		end;	

	XmNONE: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/Xm.h>] : EIF_INTEGER"
		alias
			"XmNONE"
		end;	

	XmTAB_GROUP: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/Xm.h>] : EIF_INTEGER"
		alias
			"XmTAB_GROUP"
		end;	

	XmSTICKY_TAB_GROUP: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/Xm.h>] : EIF_INTEGER"
		alias
			"XmSTICKY_TAB_GROUP"
		end;	

	XmEXCLUSIVE_TAB_GROUP: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/Xm.h>] : EIF_INTEGER"
		alias
			"XmEXCLUSIVE_TAB_GROUP"
		end;	

	XmPIXELS: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/Xm.h>] : EIF_INTEGER"
		alias
			"XmPIXELS"
		end;	

	Xm100TH_MILLIMETERS: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/Xm.h>] : EIF_INTEGER"
		alias
			"Xm100TH_MILLIMETERS"
		end;	

	Xm1000TH_INCHES: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/Xm.h>] : EIF_INTEGER"
		alias
			"Xm1000TH_INCHES"
		end;	

	Xm100TH_POINTS: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/Xm.h>] : EIF_INTEGER"
		alias
			"Xm100TH_POINTS"
		end;	

	Xm100TH_FONT_UNITS: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/Xm.h>] : EIF_INTEGER"
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




end -- class MEL_GADGET_RESOURCES


