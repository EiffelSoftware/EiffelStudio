indexing

	description: 
		"Scrolled Window resources.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_SCROLLED_WINDOW_RESOURCES

feature -- Implementation

	XmNclipWindow: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ScrolledW.h>]: EIF_POINTER"
		alias
			"XmNclipWindow"
		end;

	XmNhorizontalScrollBar: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ScrolledW.h>]: EIF_POINTER"
		alias
			"XmNhorizontalScrollBar"
		end;

	XmNscrollBarDisplayPolicy: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ScrolledW.h>]: EIF_POINTER"
		alias
			"XmNscrollBarDisplayPolicy"
		end;

	XmNscrollBarPlacement: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ScrolledW.h>]: EIF_POINTER"
		alias
			"XmNscrollBarPlacement"
		end;

	XmNscrolledWindowMarginHeight: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ScrolledW.h>]: EIF_POINTER"
		alias
			"XmNscrolledWindowMarginHeight"
		end;

	XmNscrolledWindowMarginWidth: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ScrolledW.h>]: EIF_POINTER"
		alias
			"XmNscrolledWindowMarginWidth"
		end;

	XmNscrollingPolicy: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ScrolledW.h>]: EIF_POINTER"
		alias
			"XmNscrollingPolicy"
		end;

	XmNspacing: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ScrolledW.h>]: EIF_POINTER"
		alias
			"XmNspacing"
		end;

	XmNverticalScrollBar: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ScrolledW.h>]: EIF_POINTER"
		alias
			"XmNverticalScrollBar"
		end;

	XmNvisualPolicy: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ScrolledW.h>]: EIF_POINTER"
		alias
			"XmNvisualPolicy"
		end;

	XmNworkWindow: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ScrolledW.h>]: EIF_POINTER"
		alias
			"XmNworkWindow"
		end;

	XmNtraverseObscuredCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ScrolledW.h>]: EIF_POINTER"
		alias
			"XmNtraverseObscuredCallback"
		end;

	XmSTATIC: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/ScrolledW.h>]: EIF_INTEGER"
		alias
			"XmSTATIC"
		end;

	XmAS_NEEDED: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/ScrolledW.h>]: EIF_INTEGER"
		alias
			"XmAS_NEEDED"
		end;

	XmTOP_LEFT: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/ScrolledW.h>]: EIF_INTEGER"
		alias
			"XmTOP_LEFT"
		end;

	XmBOTTOM_LEFT: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/ScrolledW.h>]: EIF_INTEGER"
		alias
			"XmBOTTOM_LEFT"
		end;

	XmTOP_RIGHT: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/ScrolledW.h>]: EIF_INTEGER"
		alias
			"XmTOP_RIGHT"
		end;

	XmBOTTOM_RIGHT: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/ScrolledW.h>]: EIF_INTEGER"
		alias
			"XmBOTTOM_RIGHT"
		end;

	XmAUTOMATIC: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/ScrolledW.h>]: EIF_INTEGER"
		alias
			"XmAUTOMATIC"
		end;

	XmAPPLICATION_DEFINED: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/ScrolledW.h>]: EIF_INTEGER"
		alias
			"XmAPPLICATION_DEFINED"
		end;

	XmCONSTANT: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/ScrolledW.h>]: EIF_INTEGER"
		alias
			"XmCONSTANT"
		end;

	XmVARIABLE: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/ScrolledW.h>]: EIF_INTEGER"
		alias
			"XmVARIABLE"
		end;

end -- class MEL_SCROLLED_WINDOW_RESOURCES


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

