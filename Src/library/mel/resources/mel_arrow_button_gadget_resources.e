note

	description: 
		"Arrow Button Gadget resources."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_ARROW_BUTTON_GADGET_RESOURCES

feature -- Implementation

	XmNmultiClick: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ArrowBG.h>] : EIF_POINTER"
		alias
			"XmNmultiClick"
		end;

	XmNarrowDirection: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ArrowBG.h>] : EIF_POINTER"
		alias
			"XmNarrowDirection"
		end;

	XmNactivateCallback: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ArrowBG.h>] : EIF_POINTER"
		alias
			"XmNactivateCallback"
		end;

	XmNarmCallback: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ArrowBG.h>] : EIF_POINTER"
		alias
			"XmNarmCallback"
		end;

	XmNdisarmCallback: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ArrowBG.h>] : EIF_POINTER"
		alias
			"XmNdisarmCallback"
		end;

	XmMULTICLICK_DISCARD: INTEGER
			-- Motif constant value 
		external
			"C [macro <Xm/ArrowBG.h>] : EIF_INTEGER"
		alias
			"XmMULTICLICK_DISCARD"
		end;

	XmMULTICLICK_KEEP: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/ArrowBG.h>] : EIF_INTEGER"
		alias
			"XmMULTICLICK_KEEP"
		end;

	XmARROW_UP: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/ArrowBG.h>] : EIF_INTEGER"
		alias
			"XmARROW_UP"
		end;

	XmARROW_DOWN: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/ArrowBG.h>] : EIF_INTEGER"
		alias
			"XmARROW_DOWN"
		end;

	XmARROW_LEFT: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/ArrowBG.h>] : EIF_INTEGER"
		alias
			"XmARROW_LEFT"
		end;

	XmARROW_RIGHT: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/ArrowBG.h>] : EIF_INTEGER"
		alias
			"XmARROW_RIGHT"
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




end -- class MEL_ARROW_BUTTON_GADGET_RESOURCES



