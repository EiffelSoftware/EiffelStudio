indexing

	description: 
		"Application context resources."
	legal: "See notice at end of class.";
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class MEL_APPLICATION_CONTEXT_RESOURCES


