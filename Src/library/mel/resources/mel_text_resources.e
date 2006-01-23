indexing

	description: 
		"Text resources."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_TEXT_RESOURCES

feature -- Implementation

	XmNautoShowCursorPosition: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Text.h>]: EIF_POINTER"
		alias
			"XmNautoShowCursorPosition"
		end;

	XmNeditMode: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Text.h>]: EIF_POINTER"
		alias
			"XmNeditMode"
		end;

	XmNsource: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Text.h>]: EIF_POINTER"
		alias
			"XmNsource"
		end;

	XmNtopCharacter: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Text.h>]: EIF_POINTER"
		alias
			"XmNtopCharacter"
		end;

	XmNresizeHeight: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Text.h>]: EIF_POINTER"
		alias
			"XmNresizeHeight"
		end;

	XmNrows: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Text.h>]: EIF_POINTER"
		alias
			"XmNrows"
		end;

	XmNwordWrap: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Text.h>]: EIF_POINTER"
		alias
			"XmNwordWrap"
		end;

	XmMULTI_LINE_EDIT: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Text.h>]: EIF_INTEGER"
		alias
			"XmMULTI_LINE_EDIT"
		end;

	XmSINGLE_LINE_EDIT: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Text.h>]: EIF_INTEGER"
		alias
			"XmSINGLE_LINE_EDIT"
		end;

	XmSELECT_ALL: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Text.h>]: EIF_INTEGER"
		alias
			"XmSELECT_ALL"
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




end -- class MEL_TEXT_RESOURCES


