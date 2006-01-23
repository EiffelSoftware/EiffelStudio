indexing

	description: 
		"Resources for paned window children."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_PANED_WINDOW_CHILD_RESOURCES

feature -- Implementation

	XmNallowResize: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/PanedW.h>]: EIF_POINTER"
		alias
			"XmNallowResize"
		end;

	XmNpaneMaximum: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/PanedW.h>]: EIF_POINTER"
		alias
			"XmNpaneMaximum"
		end;

	XmNpaneMinimum: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/PanedW.h>]: EIF_POINTER"
		alias
			"XmNpaneMinimum"
		end;

	XmNpanePositionIndex: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/PanedW.h>]: EIF_POINTER"
		alias
			"XmNpositionIndex"
		end;

	XmNskipAdjust: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/PanedW.h>]: EIF_POINTER"
		alias
			"XmNskipAdjust"
		end;

	XmPANE_LAST_POSITION: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/PanedW.h>]: EIF_INTEGER"
		alias
			"XmLAST_POSITION"
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




end -- class MEL_PANED_WINDOW_RESOURCES



