
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

--|----------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

