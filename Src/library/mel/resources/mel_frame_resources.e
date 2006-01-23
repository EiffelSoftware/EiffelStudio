indexing

	description: 
		"Frame resources."
	legal: "See notice at end of class.";
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class MEL_FRAME_RESOURCES


