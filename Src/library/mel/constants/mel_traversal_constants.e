indexing
	description: 
		"Constants for traversal direction";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_TRAVERSAL_CONSTANTS

feature -- Event types

	XmTRAVERSE_CURRENT: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmTRAVERSE_CURRENT"
		end;

	XmTRAVERSE_NEXT: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmTRAVERSE_NEXT"
		end;

	XmTRAVERSE_PREV: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmTRAVERSE_PREV"
		end;

	XmTRAVERSE_HOME: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmTRAVERSE_HOME"
		end;

	XmTRAVERSE_NEXT_TAB_GROUP: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmTRAVERSE_NEXT_TAB_GROUP"
		end;

	XmTRAVERSE_PREV_TAB_GROUP: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmTRAVERSE_PREV_TAB_GROUP"
		end;

	XmTRAVERSE_UP: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmTRAVERSE_UP"
		end;

	XmTRAVERSE_DOWN: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmTRAVERSE_DOWN"
		end;

	XmTRAVERSE_LEFT: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmTRAVERSE_LEFT"
		end;

	XmTRAVERSE_RIGHT: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmTRAVERSE_RIGHT"
		end;

end -- class MEL_TRAVERSAL_CONSTANTS

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
