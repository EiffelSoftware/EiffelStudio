indexing

	description: 
		"Shell resources."
	legal: "See notice at end of class.";
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




end -- class MEL_SHELL_RESOURCES


