indexing

	description: 
		"Arrow Button resources.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_ARROW_BUTTON_RESOURCES

feature -- Implementation

	XmNmultiClick: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ArrowB.h>] : EIF_POINTER"
		alias
			"XmNmultiClick"
		end;

	XmNarrowDirection: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ArrowB.h>] : EIF_POINTER"
		alias
			"XmNarrowDirection"
		end;

	XmNactivateCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ArrowB.h>] : EIF_POINTER"
		alias
			"XmNactivateCallback"
		end;

	XmNarmCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ArrowB.h>] : EIF_POINTER"
		alias
			"XmNarmCallback"
		end;

	XmNdisarmCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ArrowB.h>] : EIF_POINTER"
		alias
			"XmNdisarmCallback"
		end;

	XmMULTICLICK_DISCARD: INTEGER is
			-- Motif constant value 
		external
			"C [macro <Xm/ArrowB.h>] : EIF_INTEGER"
		alias
			"XmMULTICLICK_DISCARD"
		end;

	XmMULTICLICK_KEEP: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/ArrowB.h>] : EIF_INTEGER"
		alias
			"XmMULTICLICK_KEEP"
		end;

	XmARROW_UP: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/ArrowB.h>] : EIF_INTEGER"
		alias
			"XmARROW_UP"
		end;

	XmARROW_DOWN: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/ArrowB.h>] : EIF_INTEGER"
		alias
			"XmARROW_DOWN"
		end;

	XmARROW_LEFT: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/ArrowB.h>] : EIF_INTEGER"
		alias
			"XmARROW_LEFT"
		end;

	XmARROW_RIGHT: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/ArrowB.h>] : EIF_INTEGER"
		alias
			"XmARROW_RIGHT"
		end;

end -- class MEL_ARROW_BUTTON_RESOURCES



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

