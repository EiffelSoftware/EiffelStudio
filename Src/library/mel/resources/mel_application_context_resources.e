indexing

	description: 
		"Application context resources.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class MEL_APPLICATION_CONTEXT_RESOURCES

feature -- Access

	XtInputNoneMask: POINTER is
			-- Application context resource
		external
			"C [macro <X11/Intrinsic.h>]: EIF_POINTER"
		alias
			"XtInputNoneMask"
		end;

	XtInputReadMask: POINTER is
			-- Application context resource
		external
			"C [macro <X11/Intrinsic.h>]: EIF_POINTER"
		alias
			"XtInputReadMask"
		end;

	XtInputWriteMask: POINTER is
			-- Application context resource
		external
			"C [macro <X11/Intrinsic.h>]: EIF_POINTER"
		alias
			"XtInputWriteMask"
		end;

	XtInputExceptMask: POINTER is
			-- Application context resource
		external
			"C [macro <X11/Intrinsic.h>]: EIF_POINTER"
		alias
			"XtInputExceptMask"
		end;

end -- class MEL_APPLICATION_CONTEXT_RESOURCES


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

