indexing

	description: 
		"Cascade Button Gadget resources.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_CASCADE_BUTTON_GADGET_RESOURCES

feature -- Implementation

	XmNcascadePixmap: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/CascadeBG.h>] : EIF_POINTER"
		alias
			"XmNcascadePixmap"
		end;

	XmNmappingDelay: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/CascadeBG.h>] : EIF_POINTER"
		alias
			"XmNmappingDelay"
		end;

	XmNsubMenuId: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/CascadeBG.h>] : EIF_POINTER"
		alias
			"XmNsubMenuId"
		end;

	XmNactivateCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/CascadeBG.h>] : EIF_POINTER"
		alias
			"XmNactivateCallback"
		end;

	XmNcascadingCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/CascadeBG.h>] : EIF_POINTER"
		alias
			"XmNcascadingCallback"
		end;

end -- class MEL_CASCADE_BUTTON_GADGET_RESOURCES

--|----------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

