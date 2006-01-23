
indexing
	description: 
		"Constants used for drawing."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_DRAWING_CONSTANTS

feature -- Coordinate mode access

	CoordModeOrigin: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"CoordModeOrigin"
		end;

	CoordModePrevious: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"CoordModePrevious"
		end;

feature -- Shape access

	Complex: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Complex"
		end;

	Nonconvex: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Nonconvex"
		end;

	Convex: INTEGER is
		external
			"C [macro <X11/X.h>]: EIF_INTEGER"
		alias
			"Convex"
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




end -- class MEL_DRAWING_CONSTANTS

