indexing

	description: 
		"Composite resources.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_COMPOSITE_RESOURCES

feature -- Implementation

	XmNchildren: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Xm.h>]: EIF_POINTER"
		alias
			"XmNchildren"
		end;

	XmNinsertPosition: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Xm.h>]: EIF_POINTER"
		alias
			"XmNinsertPosition"
		end;

	XmNnumChildren: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Xm.h>]: EIF_POINTER"
		alias
			"XmNnumChildren"
		end;

end -- class MEL_COMPOSITE_RESOURCES

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
