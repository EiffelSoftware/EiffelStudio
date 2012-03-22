note

	description: 
		"Drawn Button resources."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class MEL_DRAWN_BUTTON_RESOURCES
		
feature -- Implementation

	XmNmultiClick: POINTER
			-- Motif resource
		external
			"C [macro <Xm/DrawnB.h>] : EIF_POINTER"
		alias
			"XmNmultiClick"
		end;

	XmNpushButtonEnabled: POINTER
			-- Motif resource
		external
			"C [macro <Xm/DrawnB.h>] : EIF_POINTER"
		alias
			"XmNpushButtonEnabled"
		end;

	XmNshadowType: POINTER
			-- Motif resource
		external
			"C [macro <Xm/DrawnB.h>] : EIF_POINTER"
		alias
			"XmNshadowType"
		end;

	XmNactivateCallback: POINTER
			-- Motif resource
		external
			"C [macro <Xm/DrawnB.h>] : EIF_POINTER"
		alias
			"XmNactivateCallback"
		end;

	XmNarmCallback: POINTER
			-- Motif resource
		external
			"C [macro <Xm/DrawnB.h>] : EIF_POINTER"
		alias
			"XmNarmCallback"
		end;

	XmNdisarmCallback: POINTER
			-- Motif resource
		external
			"C [macro <Xm/DrawnB.h>] : EIF_POINTER"
		alias
			"XmNdisarmCallback"
		end;

	XmNexposeCallback: POINTER
			-- Motif resource
		external
			"C [macro <Xm/DrawnB.h>] : EIF_POINTER"
		alias
			"XmNexposeCallback"
		end;

	XmNresizeCallback: POINTER
			-- Motif resource
		external
			"C [macro <Xm/DrawnB.h>] : EIF_POINTER"
		alias
			"XmNresizeCallback"
		end;

	XmMULTICLICK_DISCARD: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/DrawnB.h>] : EIF_INTEGER"
		alias
			"XmMULTICLICK_DISCARD"
		end;

	XmMULTICLICK_KEEP: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/DrawnB.h>] : EIF_INTEGER"
		alias
			"XmMULTICLICK_KEEP"
		end;

	XmSHADOW_IN: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/DrawnB.h>] : EIF_INTEGER"
		alias
			"XmSHADOW_IN"
		end;

	XmSHADOW_OUT: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/DrawnB.h>] : EIF_INTEGER"
		alias
			"XmSHADOW_OUT"
		end;

	XmSHADOW_ETCHED_IN: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/DrawnB.h>] : EIF_INTEGER"
		alias
			"XmSHADOW_ETCHED_IN"
		end;

	XmSHADOW_ETCHED_OUT: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/DrawnB.h>] : EIF_INTEGER"
		alias
			"XmSHADOW_ETCHED_OUT"
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




end -- class MEL_DRAWN_BUTTON


