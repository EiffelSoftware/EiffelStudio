indexing

	description: 	
		"Xt RectObj resources..";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_RECT_OBJ_RESOURCES

feature -- Implementation

	XmNancestorSensitive: POINTER is
			-- Core resource
		external
			"C [macro <Xm/Xm.h>]: EIF_POINTER"
		alias
			"XmNancestorSensitive"
		end;

	XmNborderWidth: POINTER is
			-- Core resource
		external
			"C [macro <Xm/Xm.h>]: EIF_POINTER"
		alias
			"XmNborderWidth"
		end;

	XmNheight: POINTER is
			-- Core resource
		external
			"C [macro <Xm/Xm.h>]: EIF_POINTER"
		alias
			"XmNheight"
		end;

	XmNsensitive: POINTER is
			-- Core resource
		external
			"C [macro <Xm/Xm.h>]: EIF_POINTER"
		alias
			"XmNsensitive"
		end;

	XmNwidth: POINTER is
			-- Core resource
		external
			"C [macro <Xm/Xm.h>]: EIF_POINTER"
		alias
			"XmNwidth"
		end;

	XmNx: POINTER is
			-- Core resource
		external
			"C [macro <Xm/Xm.h>]: EIF_POINTER"
		alias
			"XmNx"
		end;

	XmNy: POINTER is
			-- Core resource
		external
			"C [macro <Xm/Xm.h>]: EIF_POINTER"
		alias
			"XmNy"
		end;

end -- class MEL_RECT_OBJ_RECOURCES

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
