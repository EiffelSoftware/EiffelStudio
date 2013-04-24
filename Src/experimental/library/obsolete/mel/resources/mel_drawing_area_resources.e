note

	description: 	
		"Drawing Area resources."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_DRAWING_AREA_RESOURCES
		
feature -- Implementation

	XmNmarginHeight: POINTER
			-- Motif resource
		external
			"C [macro <Xm/DrawingA.h>]: EIF_POINTER"
		alias
			"XmNmarginHeight"
		end;

	XmNmarginWidth: POINTER
			-- Motif resource
		external
			"C [macro <Xm/DrawingA.h>]: EIF_POINTER"
		alias
			"XmNmarginWidth"
		end;

	XmNresizePolicy: POINTER
			-- Motif resource
		external
			"C [macro <Xm/DrawingA.h>]: EIF_POINTER"
		alias
			"XmNresizePolicy"
		end;

	XmRESIZE_NONE: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/DrawingA.h>]: EIF_INTEGER"
		alias
			"XmRESIZE_NONE"
		end;

	XmRESIZE_GROW: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/DrawingA.h>]: EIF_INTEGER"
		alias
			"XmRESIZE_GROW"
		end;

	XmRESIZE_ANY: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/DrawingA.h>]: EIF_INTEGER"
		alias
			"XmRESIZE_ANY"
		end;

	XmNexposeCallback: POINTER
			-- Motif resource
		external
			"C [macro <Xm/DrawingA.h>]: EIF_POINTER"
		alias
			"XmNexposeCallback"
		end;

	XmNinputCallback: POINTER
			-- Motif resource
		external
			"C [macro <Xm/DrawingA.h>]: EIF_POINTER"
		alias
			"XmNinputCallback"
		end;

	XmNresizeCallback: POINTER
			-- Motif resource
		external
			"C [macro <Xm/DrawingA.h>]: EIF_POINTER"
		alias
			"XmNresizeCallback"
		end;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class MEL_DRAWING_AREA_RESOURCES


