indexing

	description: 
		"Cascade Button resources.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_CASCADE_BUTTON_RESOURCES

feature -- Implementation

	XmNcascadePixmap: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/CascadeB.h>] : EIF_POINTER"
		alias
			"XmNcascadePixmap"
		end;

	XmNmappingDelay: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/CascadeB.h>] : EIF_POINTER"
		alias
			"XmNmappingDelay"
		end;

	XmNsubMenuId: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/CascadeB.h>] : EIF_POINTER"
		alias
			"XmNsubMenuId"
		end;

	XmNactivateCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/CascadeB.h>] : EIF_POINTER"
		alias
			"XmNactivateCallback"
		end;

	XmNcascadingCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/CascadeB.h>] : EIF_POINTER"
		alias
			"XmNcascadingCallback"
		end;

end -- class MEL_CASCADE_BUTTON_RESOURCES


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

