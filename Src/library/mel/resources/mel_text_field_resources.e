indexing

	description: 
		"Text Field defines"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_TEXT_FIELD_RESOURCES

feature -- Implementation

	XmNcursorPosition: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/TextF.h>]: EIF_POINTER"
		alias
			"XmNcursorPosition"
		end;

	XmNeditable: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/TextF.h>]: EIF_POINTER"
		alias
			"XmNeditable"
		end;

	XmNmarginHeight: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/TextF.h>]: EIF_POINTER"
		alias
			"XmNmarginHeight"
		end;

	XmNmarginWidth: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/TextF.h>]: EIF_POINTER"
		alias
			"XmNmarginWidth"
		end;

	XmNmaxLength: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/TextF.h>]: EIF_POINTER"
		alias
			"XmNmaxLength"
		end;

	XmNvalue: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/TextF.h>]: EIF_POINTER"
		alias
			"XmNvalue"
		end;

	XmNvalueWcs: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/TextF.h>]: EIF_POINTER"
		alias
			"XmNvalueWcs"
		end;

	XmNverifyBell: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/TextF.h>]: EIF_POINTER"
		alias
			"XmNverifyBell"
		end;

	XmNpendingDelete: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/TextF.h>]: EIF_POINTER"
		alias
			"XmNpendingDelete"
		end;

	XmNselectionArray: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/TextF.h>]: EIF_POINTER"
		alias
			"XmNselectionArray"
		end;

	XmNselectionArrayCount: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/TextF.h>]: EIF_POINTER"
		alias
			"XmNselectionArrayCount"
		end;

	XmNselectThreshold: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/TextF.h>]: EIF_POINTER"
		alias
			"XmNselectThreshold"
		end;

	XmNblinkRate: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/TextF.h>]: EIF_POINTER"
		alias
			"XmNblinkRate"
		end;

	XmNcolumns: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/TextF.h>]: EIF_POINTER"
		alias
			"XmNcolumns"
		end;

	XmNcursorPositionVisible: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/TextF.h>]: EIF_POINTER"
		alias
			"XmNcursorPositionVisible"
		end;

	XmNresizeWidth: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/TextF.h>]: EIF_POINTER"
		alias
			"XmNresizeWidth"
		end;

	XmNactivateCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/TextF.h>]: EIF_POINTER"
		alias
			"XmNactivateCallback"
		end;

	XmNfocusCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/TextF.h>]: EIF_POINTER"
		alias
			"XmNfocusCallback"
		end;

	XmNgainPrimaryCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/TextF.h>]: EIF_POINTER"
		alias
			"XmNgainPrimaryCallback"
		end;

	XmNlosePrimaryCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/TextF.h>]: EIF_POINTER"
		alias
			"XmNlosePrimaryCallback"
		end;

	XmNlosingFocusCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/TextF.h>]: EIF_POINTER"
		alias
			"XmNlosingFocusCallback"
		end;

	XmNmodifyVerifyCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/TextF.h>]: EIF_POINTER"
		alias
			"XmNmodifyVerifyCallback"
		end;

	XmNmodifyVerifyCallbackWcs: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/TextF.h>]: EIF_POINTER"
		alias
			"XmNmodifyVerifyCallbackWcs"
		end;

	XmNmotionVerifyCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/TextF.h>]: EIF_POINTER"
		alias
			"XmNmotionVerifyCallback"
		end;

	XmNvalueChangedCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/TextF.h>]: EIF_POINTER"
		alias
			"XmNvalueChangedCallback"
		end;

	XmSELECT_POSITION: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/TextF.h>]: EIF_INTEGER"
		alias
			"XmSELECT_POSITION"
		end;

	XmSELECT_WORD: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/TextF.h>]: EIF_INTEGER"
		alias
			"XmSELECT_WORD"
		end;

	XmSELECT_LINE: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/TextF.h>]: EIF_INTEGER"
		alias
			"XmSELECT_LINE"
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




end -- class MEL_TEXT_FIELD_RESOURCES


