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
