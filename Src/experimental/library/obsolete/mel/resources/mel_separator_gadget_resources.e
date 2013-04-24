note

	description: 
		"Separator Gadget resources."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_SEPARATOR_GADGET_RESOURCES

feature -- Implementation

	XmNmargin: POINTER
			-- Motif resource
		external
			"C [macro <Xm/SeparatoG.h>] : EIF_POINTER"
		alias
			"XmNmargin"
		end;


	XmNseparatorType: POINTER
			-- Motif resource
		external
			"C [macro <Xm/SeparatoG.h>] : EIF_POINTER"
		alias
			"XmNseparatorType"
		end;

	XmNorientation: POINTER
			-- Motif resource
		external
			"C [macro <Xm/SeparatoG.h>] : EIF_POINTER"
		alias
			"XmNorientation"
		end;

	XmVERTICAL: INTEGER
			-- Motif constant value
		external
			 "C [macro <Xm/SeparatoG.h>] : EIF_INTEGER"
		alias
			"XmVERTICAL"
		end;

	XmHORIZONTAL: INTEGER
			-- Motif constant value
		external
			 "C [macro <Xm/SeparatoG.h>] : EIF_INTEGER"
		alias
			"XmHORIZONTAL"
		end;

	XmNO_LINE: INTEGER
			-- Motif constant value
		external
			 "C [macro <Xm/SeparatoG.h>] : EIF_INTEGER"
		alias
			"XmNO_LINE"
		end;

	XmSINGLE_LINE: INTEGER
			-- Motif constant value
		external
			 "C [macro <Xm/SeparatoG.h>] : EIF_INTEGER"
		alias
			"XmSINGLE_LINE"
		end;

	XmDOUBLE_LINE: INTEGER
			-- Motif constant value
		external
			 "C [macro <Xm/SeparatoG.h>] : EIF_INTEGER"
		alias
			"XmDOUBLE_LINE"
		end;

	XmSINGLE_DASHED_LINE: INTEGER
			-- Motif constant value
		external
			 "C [macro <Xm/SeparatoG.h>] : EIF_INTEGER"
		alias
			"XmSINGLE_DASHED_LINE"
		end;

	XmDOUBLE_DASHED_LINE: INTEGER
			-- Motif constant value
		external
			 "C [macro <Xm/SeparatoG.h>] : EIF_INTEGER"
		alias
			"XmDOUBLE_DASHED_LINE"
		end;

	XmSHADOW_ETCHED_IN: INTEGER
			-- Motif constant value
		external
			 "C [macro <Xm/SeparatoG.h>] : EIF_INTEGER"
		alias
			"XmSHADOW_ETCHED_IN"
		end;

	XmSHADOW_ETCHED_OUT: INTEGER
			-- Motif constant value
		external
			 "C [macro <Xm/SeparatoG.h>] : EIF_INTEGER"
		alias
			"XmSHADOW_ETCHED_OUT"
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




end -- class MEL_SEPARATOR_GADGET_RESOURCES


