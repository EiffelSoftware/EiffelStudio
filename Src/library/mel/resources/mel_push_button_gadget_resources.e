indexing

	description: 
		"Push Button Gadget resources."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_PUSH_BUTTON_GADGET_RESOURCES

feature -- Implementation

	XmNarmColor: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/PushBG.h>] : EIF_POINTER"
		alias
			"XmNarmColor"
		end;

	XmNarmPixmap: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/PushBG.h>] : EIF_POINTER"
		alias
			"XmNarmPixmap"
		end;

	XmNdefaultButtonShadowThickness: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/PushBG.h>] : EIF_POINTER"
		alias
			"XmNdefaultButtonShadowThickness"
		end;

	XmNfillOnArm: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/PushBG.h>] : EIF_POINTER"
		alias
			"XmNfillOnArm"
		end;

	XmNmultiClick: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/PushBG.h>] : EIF_POINTER"
		alias
			"XmNmultiClick"
		end;

	XmNshowAsDefault: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/PushBG.h>] : EIF_POINTER"
		alias
			"XmNshowAsDefault"
		end;

	XmNactivateCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/PushBG.h>] : EIF_POINTER"
		alias
			"XmNactivateCallback"
		end;

	XmNarmCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/PushBG.h>] : EIF_POINTER"
		alias
			"XmNarmCallback"
		end;

	XmNdisarmCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/PushBG.h>] : EIF_POINTER"
		alias
			"XmNdisarmCallback"
		end;

	XmMULTICLICK_DISCARD: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/PushBG.h>] : EIF_INTEGER"
		alias
			"XmMULTICLICK_DISCARD"
		end;

	XmMULTICLICK_KEEP: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/PushBG.h>] : EIF_INTEGER"
		alias
			"XmMULTICLICK_KEEP"
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




end -- class MEL_PUSH_BUTTON_GADGET_RESOURCES



