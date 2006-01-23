indexing

	description: 
		"Motif Form resources."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_FORM_RESOURCES

feature -- Implementation

	XmNfractionBase: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Form.h>]: EIF_POINTER"
		alias
			"XmNfractionBase"
		end;

	XmNhorizontalSpacing: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Form.h>]: EIF_POINTER"
		alias
			"XmNhorizontalSpacing"
		end;

	XmNrubberPositioning: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Form.h>]: EIF_POINTER"
		alias
			"XmNrubberPositioning"
		end;

	XmNverticalSpacing: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Form.h>]: EIF_POINTER"
		alias
			"XmNverticalSpacing"
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




end -- class MEL_FORM_RESOURCES


