indexing
	description: 
		"Constants for traversal direction"
	legal: "See notice at end of class.";
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




end -- class MEL_TRAVERSAL_CONSTANTS


