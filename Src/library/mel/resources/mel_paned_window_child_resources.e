indexing

	description: 
		"Resources for paned window children.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_PANED_WINDOW_CHILD_RESOURCES

feature -- Implementation

	XmNallowResize: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/PanedW.h>]: EIF_POINTER"
		alias
			"XmNallowResize"
		end;

	XmNpaneMaximum: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/PanedW.h>]: EIF_POINTER"
		alias
			"XmNpaneMaximum"
		end;

	XmNpaneMinimum: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/PanedW.h>]: EIF_POINTER"
		alias
			"XmNpaneMinimum"
		end;

	XmNpanePositionIndex: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/PanedW.h>]: EIF_POINTER"
		alias
			"XmNpositionIndex"
		end;

	XmNskipAdjust: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/PanedW.h>]: EIF_POINTER"
		alias
			"XmNskipAdjust"
		end;

	XmPANE_LAST_POSITION: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/PanedW.h>]: EIF_INTEGER"
		alias
			"XmLAST_POSITION"
		end;

end -- class MEL_PANED_WINDOW_RESOURCES


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
