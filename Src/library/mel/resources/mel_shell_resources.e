indexing

	description: 
		"Shell resources.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_SHELL_RESOURCES

feature {NONE} 

	XmNallowShellResize: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNallowShellResize"
		end;

	XmNcreatePopupChildProc: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNcreatePopupChildProc"
		end;

	XmNgeometry: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNgeometry"
		end;

	XmNoverrideRedirect: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNoverrideRedirect"
		end;

	XmNpopdownCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNpopdownCallback"
		end;

	XmNpopupCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNpopupCallback"
		end;

	XmNsaveUnder: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNsaveUnder"
		end;

	XmNvisual: POINTER is
			-- Motif resource
			-- From New R4 pseudo defines
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNvisual"
		end;

end -- class MEL_SHELL_RESOURCES

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
