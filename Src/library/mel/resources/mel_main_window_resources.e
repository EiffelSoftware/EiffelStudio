indexing

	description: 
		"Main Window resources."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_MAIN_WINDOW_RESOURCES

feature -- Implementation

	XmNcommandWindow: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/MainW.h>]: EIF_POINTER"
		alias
			"XmNcommandWindow"
		end;

	XmNcommandWindowLocation: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/MainW.h>]: EIF_POINTER"
		alias
			"XmNcommandWindowLocation"
		end;

	XmNmainWindowMarginHeight: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/MainW.h>]: EIF_POINTER"
		alias
			"XmNmainWindowMarginHeight"
		end;

	XmNmainWindowMarginWidth: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/MainW.h>]: EIF_POINTER"
		alias
			"XmNmainWindowMarginWidth"
		end;

	XmNmenuBar: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/MainW.h>]: EIF_POINTER"
		alias
			"XmNmenuBar"
		end;

	XmNmessageWindow: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/MainW.h>]: EIF_POINTER"
		alias
			"XmNmessageWindow"
		end;

	XmNshowSeparator: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/MainW.h>]: EIF_POINTER"
		alias
			"XmNshowSeparator"
		end;

	XmCOMMAND_ABOVE_WORKSPACE: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/MainW.h>]: EIF_INTEGER"
		alias
			"XmCOMMAND_ABOVE_WORKSPACE"
		end;

	XmCOMMAND_BELOW_WORKSPACE: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/MainW.h>]: EIF_INTEGER"
		alias
			"XmCOMMAND_BELOW_WORKSPACE"
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




end -- class MEL_MAIN_WINDOW_RESOURCES


