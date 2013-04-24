note

	description: 
		"Message Box resources."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_MESSAGE_BOX_RESOURCES

feature -- Implementation

	XmNcancelLabelString: POINTER
			-- Motif resource
		external
			"C [macro <Xm/MessageB.h>]: EIF_POINTER"
		alias
			"XmNcancelLabelString"
		end;

	XmNdefaultButtonType: POINTER
			-- Motif resource
		external
			"C [macro <Xm/MessageB.h>]: EIF_POINTER"
		alias
			"XmNdefaultButtonType"
		end;

	XmNdialogType: POINTER
			-- Motif resource
		external
			"C [macro <Xm/MessageB.h>]: EIF_POINTER"
		alias
			"XmNdialogType"
		end;

	XmNhelpLabelString: POINTER
			-- Motif resource
		external
			"C [macro <Xm/MessageB.h>]: EIF_POINTER"
		alias
			"XmNhelpLabelString"
		end;

	XmNmessageAlignment: POINTER
			-- Motif resource
		external
			"C [macro <Xm/MessageB.h>]: EIF_POINTER"
		alias
			"XmNmessageAlignment"
		end;

	XmNmessageString: POINTER
			-- Motif resource
		external
			"C [macro <Xm/MessageB.h>]: EIF_POINTER"
		alias
			"XmNmessageString"
		end;

	XmNminimizeButtons: POINTER
			-- Motif resource
		external
			"C [macro <Xm/MessageB.h>]: EIF_POINTER"
		alias
			"XmNminimizeButtons"
		end;

	XmNokLabelString: POINTER
			-- Motif resource
		external
			"C [macro <Xm/MessageB.h>]: EIF_POINTER"
		alias
			"XmNokLabelString"
		end;

	XmNsymbolPixmap: POINTER
			-- Motif resource
		external
			"C [macro <Xm/MessageB.h>]: EIF_POINTER"
		alias
			"XmNsymbolPixmap"
		end;

	XmNcancelCallback: POINTER
			-- Motif resource
		external
			"C [macro <Xm/MessageB.h>]: EIF_POINTER"
		alias
			"XmNcancelCallback"
		end;

	XmNokCallback: POINTER
			-- Motif resource
		external
			"C [macro <Xm/MessageB.h>]: EIF_POINTER"
		alias
			"XmNokCallback"
		end;

	XmDIALOG_CANCEL_BUTTON: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/MessageB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_CANCEL_BUTTON"
		end;

	XmDIALOG_OK_BUTTON: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/MessageB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_OK_BUTTON"
		end;

	XmDIALOG_HELP_BUTTON: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/MessageB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_HELP_BUTTON"
		end;

	XmDIALOG_MESSAGE_LABEL: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/MessageB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_MESSAGE_LABEL"
		end;

	XmDIALOG_SEPARATOR: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/MessageB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_SEPARATOR"
		end;

	XmDIALOG_SYMBOL_LABEL: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/MessageB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_SYMBOL_LABEL"
		end;

	XmDIALOG_ERROR: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/MessageB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_ERROR"
		end;

	XmDIALOG_INFORMATION: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/MessageB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_INFORMATION"
		end;

	XmDIALOG_MESSAGE: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/MessageB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_MESSAGE"
		end;

	XmDIALOG_QUESTION: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/MessageB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_QUESTION"
		end;

	XmDIALOG_TEMPLATE: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/MessageB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_TEMPLATE"
		end;

	XmDIALOG_WARNING: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/MessageB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_WARNING"
		end;

	XmDIALOG_WORKING: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/MessageB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_WORKING"
		end;

	XmALIGNMENT_BEGINNING: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/MessageB.h>]: EIF_INTEGER"
		alias
			"XmALIGNMENT_BEGINNING"
		end;

	XmALIGNMENT_CENTER: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/MessageB.h>]: EIF_INTEGER"
		alias
			"XmALIGNMENT_CENTER"
		end;

	XmALIGNMENT_END: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/MessageB.h>]: EIF_INTEGER"
		alias
			"XmALIGNMENT_END"
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




end -- class MEL_MESSAGE_BOX_RESOURCES


