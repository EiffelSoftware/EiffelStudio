indexing

	description: 
		"Push Button resources.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_PUSH_BUTTON_RESOURCES

feature -- Implementation

	XmNarmColor: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/PushB.h>] : EIF_POINTER"
		alias
			"XmNarmColor"
		end;

	XmNarmPixmap: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/PushB.h>] : EIF_POINTER"
		alias
			"XmNarmPixmap"
		end;

	XmNdefaultButtonShadowThickness: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/PushB.h>] : EIF_POINTER"
		alias
			"XmNdefaultButtonShadowThickness"
		end;

	XmNfillOnArm: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/PushB.h>] : EIF_POINTER"
		alias
			"XmNfillOnArm"
		end;

	XmNmultiClick: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/PushB.h>] : EIF_POINTER"
		alias
			"XmNmultiClick"
		end;

	XmNshowAsDefault: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/PushB.h>] : EIF_POINTER"
		alias
			"XmNshowAsDefault"
		end;

	XmNactivateCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/PushB.h>] : EIF_POINTER"
		alias
			"XmNactivateCallback"
		end;

	XmNarmCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/PushB.h>] : EIF_POINTER"
		alias
			"XmNarmCallback"
		end;

	XmNdisarmCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/PushB.h>] : EIF_POINTER"
		alias
			"XmNdisarmCallback"
		end;

	XmMULTICLICK_DISCARD: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/PushB.h>] : EIF_INTEGER"
		alias
			"XmMULTICLICK_DISCARD"
		end;

	XmMULTICLICK_KEEP: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/PushB.h>] : EIF_INTEGER"
		alias
			"XmMULTICLICK_KEEP"
		end;

end -- class MEL_PUSH_BUTTON_RESOURCES


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
