note

	description: 
		"Scrolled Window resources."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_SCROLLED_WINDOW_RESOURCES

feature -- Implementation

	XmNclipWindow: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ScrolledW.h>]: EIF_POINTER"
		alias
			"XmNclipWindow"
		end;

	XmNhorizontalScrollBar: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ScrolledW.h>]: EIF_POINTER"
		alias
			"XmNhorizontalScrollBar"
		end;

	XmNscrollBarDisplayPolicy: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ScrolledW.h>]: EIF_POINTER"
		alias
			"XmNscrollBarDisplayPolicy"
		end;

	XmNscrollBarPlacement: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ScrolledW.h>]: EIF_POINTER"
		alias
			"XmNscrollBarPlacement"
		end;

	XmNscrolledWindowMarginHeight: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ScrolledW.h>]: EIF_POINTER"
		alias
			"XmNscrolledWindowMarginHeight"
		end;

	XmNscrolledWindowMarginWidth: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ScrolledW.h>]: EIF_POINTER"
		alias
			"XmNscrolledWindowMarginWidth"
		end;

	XmNscrollingPolicy: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ScrolledW.h>]: EIF_POINTER"
		alias
			"XmNscrollingPolicy"
		end;

	XmNspacing: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ScrolledW.h>]: EIF_POINTER"
		alias
			"XmNspacing"
		end;

	XmNverticalScrollBar: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ScrolledW.h>]: EIF_POINTER"
		alias
			"XmNverticalScrollBar"
		end;

	XmNvisualPolicy: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ScrolledW.h>]: EIF_POINTER"
		alias
			"XmNvisualPolicy"
		end;

	XmNworkWindow: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ScrolledW.h>]: EIF_POINTER"
		alias
			"XmNworkWindow"
		end;

	XmNtraverseObscuredCallback: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ScrolledW.h>]: EIF_POINTER"
		alias
			"XmNtraverseObscuredCallback"
		end;

	XmSTATIC: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/ScrolledW.h>]: EIF_INTEGER"
		alias
			"XmSTATIC"
		end;

	XmAS_NEEDED: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/ScrolledW.h>]: EIF_INTEGER"
		alias
			"XmAS_NEEDED"
		end;

	XmTOP_LEFT: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/ScrolledW.h>]: EIF_INTEGER"
		alias
			"XmTOP_LEFT"
		end;

	XmBOTTOM_LEFT: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/ScrolledW.h>]: EIF_INTEGER"
		alias
			"XmBOTTOM_LEFT"
		end;

	XmTOP_RIGHT: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/ScrolledW.h>]: EIF_INTEGER"
		alias
			"XmTOP_RIGHT"
		end;

	XmBOTTOM_RIGHT: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/ScrolledW.h>]: EIF_INTEGER"
		alias
			"XmBOTTOM_RIGHT"
		end;

	XmAUTOMATIC: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/ScrolledW.h>]: EIF_INTEGER"
		alias
			"XmAUTOMATIC"
		end;

	XmAPPLICATION_DEFINED: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/ScrolledW.h>]: EIF_INTEGER"
		alias
			"XmAPPLICATION_DEFINED"
		end;

	XmCONSTANT: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/ScrolledW.h>]: EIF_INTEGER"
		alias
			"XmCONSTANT"
		end;

	XmVARIABLE: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/ScrolledW.h>]: EIF_INTEGER"
		alias
			"XmVARIABLE"
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




end -- class MEL_SCROLLED_WINDOW_RESOURCES


