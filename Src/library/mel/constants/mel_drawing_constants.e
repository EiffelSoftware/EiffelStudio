
indexing
	description: 
		"Constants used for drawing.";
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

end -- class MEL_DRAWING_CONSTANTS
