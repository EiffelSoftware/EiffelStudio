indexing

	description: 
		"Motif Form resources.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_FORM_RESOURCES

feature -- Implementation

	XmNfractionBase: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Form.h>]: EIF_POINTER"
		alias
			"XmNfractionBase"
		end;

	XmNhorizontalSpacing: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Form.h>]: EIF_POINTER"
		alias
			"XmNhorizontalSpacing"
		end;

	XmNrubberPositioning: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Form.h>]: EIF_POINTER"
		alias
			"XmNrubberPositioning"
		end;

	XmNverticalSpacing: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Form.h>]: EIF_POINTER"
		alias
			"XmNverticalSpacing"
		end;

end -- class MEL_FORM_RESOURCES

--|----------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1997 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
