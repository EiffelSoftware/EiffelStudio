indexing

	description: 
		"Frame resources.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_FRAME_RESOURCES

feature -- Access

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
