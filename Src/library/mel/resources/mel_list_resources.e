indexing

	description: 
		"List resources.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_LIST_RESOURCES

feature  -- Implementation

	XmNautomaticSelection: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/List.h>] : EIF_POINTER"
		alias
			"XmNautomaticSelection"
		end;

	XmNdoubleClickInterval: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/List.h>] : EIF_POINTER"
		alias
			"XmNdoubleClickInterval"
		end;

	XmNitemCount: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/List.h>] : EIF_POINTER"
		alias
			"XmNitemCount"
		end;

	XmNitems: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/List.h>] : EIF_POINTER"
		alias
			"XmNitems"
		end;

	XmNlistMarginHeight: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/List.h>] : EIF_POINTER"
		alias
			"XmNlistMarginHeight"
		end;

	XmNlistMarginWidth: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/List.h>] : EIF_POINTER"
		alias
			"XmNlistMarginWidth"
		end;

	XmNlistSizePolicy: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/List.h>] : EIF_POINTER"
		alias
			"XmNlistSizePolicy"
		end;

	XmNlistSpacing: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/List.h>] : EIF_POINTER"
		alias
			"XmNlistSpacing"
		end;

	XmNscrollBarDisplayPolicy: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/List.h>] : EIF_POINTER"
		alias
			"XmNscrollBarDisplayPolicy"
		end;

	XmNselectedItemCount: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/List.h>] : EIF_POINTER"
		alias
			"XmNselectedItemCount"
		end;

	XmNselectedItems: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/List.h>] : EIF_POINTER"
		alias
			"XmNselectedItems"
		end;

	XmNselectionPolicy: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/List.h>] : EIF_POINTER"
		alias
			"XmNselectionPolicy"
		end;

	XmNstringDirection: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/List.h>] : EIF_POINTER"
		alias
			"XmNstringDirection"
		end;

	XmNtopItemPosition: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/List.h>] : EIF_POINTER"
		alias
			"XmNtopItemPosition"
		end;

	XmNvisibleItemCount: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/List.h>] : EIF_POINTER"
		alias
			"XmNvisibleItemCount"
		end;

	XmNbrowseSelectionCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/List.h>] : EIF_POINTER"
		alias
			"XmNbrowseSelectionCallback"
		end;

	XmNdefaultActionCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/List.h>] : EIF_POINTER"
		alias
			"XmNdefaultActionCallback"
		end;

	XmNextendedSelectionCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/List.h>] : EIF_POINTER"
		alias
			"XmNextendedSelectionCallback"
		end;

	XmNmultipleSelectionCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/List.h>] : EIF_POINTER"
		alias
			"XmNmultipleSelectionCallback"
		end;

	XmNsingleSelectionCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/List.h>] : EIF_POINTER"
		alias
			"XmNsingleSelectionCallback"
		end;

	XmVARIABLE: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/List.h>] : EIF_INTEGER"
		alias
			"XmVARIABLE"
		end;
 
	XmCONSTANT: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/List.h>] : EIF_INTEGER"
		alias
			"XmCONSTANT"
		end;

	XmRESIZE_IF_POSSIBLE: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/List.h>] : EIF_INTEGER"
		alias
			"XmRESIZE_IF_POSSIBLE"
		end;

	XmSINGLE_SELECT: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/List.h>] : EIF_INTEGER"
		alias
			"XmSINGLE_SELECT"
		end;

	XmMULTIPLE_SELECT: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/List.h>] : EIF_INTEGER"
		alias
			"XmMULTIPLE_SELECT"
		end;

	XmEXTENDED_SELECT: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/List.h>] : EIF_INTEGER"
		alias
			"XmEXTENDED_SELECT"
		end;

	XmBROWSE_SELECT: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/List.h>] : EIF_INTEGER"
		alias
			"XmBROWSE_SELECT"
		end;

	XmSTATIC: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/List.h>] : EIF_INTEGER"
		alias
			"XmSTATIC"
		end;

	XmAS_NEEDED: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/List.h>] : EIF_INTEGER"
		alias
			"XmAS_NEEDED"
		end;

	XmSTRING_DIRECTION_L_TO_R: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Label.h>] : EIF_INTEGER"
		alias
			"XmSTRING_DIRECTION_L_TO_R"
		end;

	XmSTRING_DIRECTION_R_TO_L: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Label.h>] : EIF_INTEGER"
		alias
			"XmSTRING_DIRECTION_R_TO_L"
		end;

	XmSTRING_DIRECTION_DEFAULT: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Label.h>] : EIF_INTEGER"
		alias
			"XmSTRING_DIRECTION_DEFAULT"
		end;

end -- class MEL_LIST_RESOURCES


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

