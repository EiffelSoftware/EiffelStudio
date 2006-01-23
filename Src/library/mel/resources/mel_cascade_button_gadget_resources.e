indexing

	description: 
		"Cascade Button Gadget resources."
	legal: "See notice at end of class.";
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




end -- class MEL_CASCADE_BUTTON_GADGET_RESOURCES


