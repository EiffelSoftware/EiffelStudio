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
