indexing

	description: 
		"Frame resources.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_FRAME_RESOURCES

feature -- Implementation

	XmNmarginHeight: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Frame.h>]: EIF_POINTER"
		alias
			"XmNmarginHeight"
		end;

	XmNmarginWidth: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Frame.h>]: EIF_POINTER"
		alias
			"XmNmarginWidth"
		end;

	XmNshadowType: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Frame.h>]: EIF_POINTER"
		alias
			"XmNshadowType"
		end;

	XmSHADOW_IN: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Frame.h>]: EIF_INTEGER"
		alias
			"XmSHADOW_IN"
		end;

	XmSHADOW_OUT: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Frame.h>]: EIF_INTEGER"
		alias
			"XmSHADOW_OUT"
		end;

	XmSHADOW_ETCHED_IN: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Frame.h>]: EIF_INTEGER"
		alias
			"XmSHADOW_ETCHED_IN"
		end;

	XmSHADOW_ETCHED_OUT: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Frame.h>]: EIF_INTEGER"
		alias
			"XmSHADOW_ETCHED_OUT"
		end;

	XmNchildType: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Frame.h>]: EIF_POINTER"
		alias
			"XmNchildType"
		end;

	XmNchildHorizontalAlignment: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Frame.h>]: EIF_POINTER"
		alias
			"XmNchildHorizontalAlignment"
		end;

	XmNchildHorizontalSpacing: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Frame.h>]: EIF_POINTER"
		alias
			"XmNchildHorizontalSpacing"
		end;

	XmNchildVerticalAlignment: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Frame.h>]: EIF_POINTER"
		alias
			"XmNchildVerticalAlignment"
		end;

	XmFRAME_TITLE_CHILD: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Frame.h>]: EIF_INTEGER"
		alias
			"XmFRAME_TITLE_CHILD"
		end;

	XmFRAME_WORKAREA_CHILD: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Frame.h>]: EIF_INTEGER"
		alias
			"XmFRAME_WORKAREA_CHILD"
		end;

	XmFRAME_GENERIC_CHILD: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Frame.h>]: EIF_INTEGER"
		alias
			"XmFRAME_GENERIC_CHILD"
		end;

	XmALIGNMENT_BEGINNING: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Frame.h>]: EIF_INTEGER"
		alias
			"XmALIGNMENT_BEGINNING"
		end;

	XmALIGNMENT_END: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Frame.h>]: EIF_INTEGER"
		alias
			"XmALIGNMENT_END"
		end;

	XmALIGNMENT_BASELINE_BOTTOM: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Frame.h>]: EIF_INTEGER"
		alias
			"XmALIGNMENT_BASELINE_BOTTOM"
		end;

	XmALIGNMENT_BASELINE_TOP: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Frame.h>]: EIF_INTEGER"
		alias
			"XmALIGNMENT_BASELINE_TOP"
		end;

	XmALIGNMENT_WIDGET_TOP: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Frame.h>]: EIF_INTEGER"
		alias
			"XmALIGNMENT_WIDGET_TOP"
		end;

	XmALIGNMENT_CENTER: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Frame.h>]: EIF_INTEGER"
		alias
			"XmALIGNMENT_CENTER"
		end;

	XmALIGNMENT_WIDGET_BOTTOM: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Frame.h>]: EIF_INTEGER"
		alias
			"XmALIGNMENT_WIDGET_BOTTOM"
		end;

end -- class MEL_FRAME_RESOURCES

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
