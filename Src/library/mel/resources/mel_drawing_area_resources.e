indexing

	description: 	
		"Drawing Area resources."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_DRAWING_AREA_RESOURCES
		
feature -- Implementation

	XmNmarginHeight: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/DrawingA.h>]: EIF_POINTER"
		alias
			"XmNmarginHeight"
		end;

	XmNmarginWidth: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/DrawingA.h>]: EIF_POINTER"
		alias
			"XmNmarginWidth"
		end;

	XmNresizePolicy: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/DrawingA.h>]: EIF_POINTER"
		alias
			"XmNresizePolicy"
		end;

	XmRESIZE_NONE: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/DrawingA.h>]: EIF_INTEGER"
		alias
			"XmRESIZE_NONE"
		end;

	XmRESIZE_GROW: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/DrawingA.h>]: EIF_INTEGER"
		alias
			"XmRESIZE_GROW"
		end;

	XmRESIZE_ANY: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/DrawingA.h>]: EIF_INTEGER"
		alias
			"XmRESIZE_ANY"
		end;

	XmNexposeCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/DrawingA.h>]: EIF_POINTER"
		alias
			"XmNexposeCallback"
		end;

	XmNinputCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/DrawingA.h>]: EIF_POINTER"
		alias
			"XmNinputCallback"
		end;

	XmNresizeCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/DrawingA.h>]: EIF_POINTER"
		alias
			"XmNresizeCallback"
		end;

end -- class MEL_DRAWING_AREA_RESOURCES


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

