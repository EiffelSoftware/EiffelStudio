indexing

	description: 
		"Message Box resources.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_MESSAGE_BOX_RESOURCES

feature -- Implementation

	XmNcancelLabelString: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/MessageB.h>]: EIF_POINTER"
		alias
			"XmNcancelLabelString"
		end;

	XmNdefaultButtonType: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/MessageB.h>]: EIF_POINTER"
		alias
			"XmNdefaultButtonType"
		end;

	XmNdialogType: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/MessageB.h>]: EIF_POINTER"
		alias
			"XmNdialogType"
		end;

	XmNhelpLabelString: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/MessageB.h>]: EIF_POINTER"
		alias
			"XmNhelpLabelString"
		end;

	XmNmessageAlignment: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/MessageB.h>]: EIF_POINTER"
		alias
			"XmNmessageAlignment"
		end;

	XmNmessageString: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/MessageB.h>]: EIF_POINTER"
		alias
			"XmNmessageString"
		end;

	XmNminimizeButtons: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/MessageB.h>]: EIF_POINTER"
		alias
			"XmNminimizeButtons"
		end;

	XmNokLabelString: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/MessageB.h>]: EIF_POINTER"
		alias
			"XmNokLabelString"
		end;

	XmNsymbolPixmap: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/MessageB.h>]: EIF_POINTER"
		alias
			"XmNsymbolPixmap"
		end;

	XmNcancelCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/MessageB.h>]: EIF_POINTER"
		alias
			"XmNcancelCallback"
		end;

	XmNokCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/MessageB.h>]: EIF_POINTER"
		alias
			"XmNokCallback"
		end;

	XmDIALOG_CANCEL_BUTTON: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/MessageB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_CANCEL_BUTTON"
		end;

	XmDIALOG_OK_BUTTON: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/MessageB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_OK_BUTTON"
		end;

	XmDIALOG_HELP_BUTTON: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/MessageB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_HELP_BUTTON"
		end;

	XmDIALOG_MESSAGE_LABEL: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/MessageB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_MESSAGE_LABEL"
		end;

	XmDIALOG_SEPARATOR: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/MessageB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_SEPARATOR"
		end;

	XmDIALOG_SYMBOL_LABEL: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/MessageB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_SYMBOL_LABEL"
		end;

	XmDIALOG_ERROR: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/MessageB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_ERROR"
		end;

	XmDIALOG_INFORMATION: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/MessageB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_INFORMATION"
		end;

	XmDIALOG_MESSAGE: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/MessageB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_MESSAGE"
		end;

	XmDIALOG_QUESTION: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/MessageB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_QUESTION"
		end;

	XmDIALOG_TEMPLATE: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/MessageB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_TEMPLATE"
		end;

	XmDIALOG_WARNING: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/MessageB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_WARNING"
		end;

	XmDIALOG_WORKING: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/MessageB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_WORKING"
		end;

	XmALIGNMENT_BEGINNING: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/MessageB.h>]: EIF_INTEGER"
		alias
			"XmALIGNMENT_BEGINNING"
		end;

	XmALIGNMENT_CENTER: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/MessageB.h>]: EIF_INTEGER"
		alias
			"XmALIGNMENT_CENTER"
		end;

	XmALIGNMENT_END: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/MessageB.h>]: EIF_INTEGER"
		alias
			"XmALIGNMENT_END"
		end;

end -- class MEL_MESSAGE_BOX_RESOURCES


--|----------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

