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

