indexing

	description: 
		"Selection Box resources.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_SELECTION_BOX_RESOURCES

feature -- Implementation

	XmNapplyLabelString: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/SelectioB.h>]: EIF_POINTER"
		alias
			"XmNapplyLabelString"
		end;

	XmNcancelLabelString: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/SelectioB.h>]: EIF_POINTER"
		alias
			"XmNcancelLabelString"
		end;

	XmNchildPlacement: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/SelectioB.h>]: EIF_POINTER"
		alias
			"XmNchildPlacement"
		end;

	XmNdialogType: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/SelectioB.h>]: EIF_POINTER"
		alias
			"XmNdialogType"
		end;

	XmNhelpLabelString: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/SelectioB.h>]: EIF_POINTER"
		alias
			"XmNhelpLabelString"
		end;

	XmNlistItemCount: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/SelectioB.h>]: EIF_POINTER"
		alias
			"XmNlistItemCount"
		end;

	XmNlistItems: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/SelectioB.h>]: EIF_POINTER"
		alias
			"XmNlistItems"
		end;

	XmNlistLabelString: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/SelectioB.h>]: EIF_POINTER"
		alias
			"XmNlistLabelString"
		end;

	XmNlistVisibleItemCount: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/SelectioB.h>]: EIF_POINTER"
		alias
			"XmNlistVisibleItemCount"
		end;

	XmNminimizeButtons: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/SelectioB.h>]: EIF_POINTER"
		alias
			"XmNminimizeButtons"
		end;

	XmNmustMatch: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/SelectioB.h>]: EIF_POINTER"
		alias
			"XmNmustMatch"
		end;

	XmNokLabelString: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/SelectioB.h>]: EIF_POINTER"
		alias
			"XmNokLabelString"
		end;

	XmNselectionLabelString: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/SelectioB.h>]: EIF_POINTER"
		alias
			"XmNselectionLabelString"
		end;

	XmNtextAccelerators: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/SelectioB.h>]: EIF_POINTER"
		alias
			"XmNtextAccelerators"
		end;

	XmNtextColumns: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/SelectioB.h>]: EIF_POINTER"
		alias
			"XmNtextColumns"
		end;

	XmNtextString: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/SelectioB.h>]: EIF_POINTER"
		alias
			"XmNtextString"
		end;

	XmNapplyCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/SelectioB.h>]: EIF_POINTER"
		alias
			"XmNapplyCallback"
		end;

	XmNcancelCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/SelectioB.h>]: EIF_POINTER"
		alias
			"XmNcancelCallback"
		end;

	XmNnoMatchCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/SelectioB.h>]: EIF_POINTER"
		alias
			"XmNnoMatchCallback"
		end;

	XmNokCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/SelectioB.h>]: EIF_POINTER"
		alias
			"XmNokCallback"
		end;

	XmPLACE_ABOVE_SELECTION: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/SelectioB.h>]: EIF_INTEGER"
		alias
			"XmPLACE_ABOVE_SELECTION"
		end;

	XmPLACE_BELOW_SELECTION: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/SelectioB.h>]: EIF_INTEGER"
		alias
			"XmPLACE_BELOW_SELECTION"
		end;

	XmPLACE_TOP: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/SelectioB.h>]: EIF_INTEGER"
		alias
			"XmPLACE_TOP"
		end;

	XmDIALOG_PROMPT: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/SelectioB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_PROMPT"
		end;

	XmDIALOG_SELECTION: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/SelectioB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_SELECTION"
		end;

	XmDIALOG_COMMAND: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/SelectioB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_COMMAND"
		end;

	XmDIALOG_FILE_SELECTION: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/SelectioB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_FILE_SELECTION"
		end;

	XmDIALOG_APPLY_BUTTON: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/SelectioB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_APPLY_BUTTON"
		end;

	XmDIALOG_CANCEL_BUTTON: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/SelectioB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_CANCEL_BUTTON"
		end;

	XmDIALOG_DEFAULT_BUTTON: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/SelectioB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_DEFAULT_BUTTON"
		end;

	XmDIALOG_HELP_BUTTON: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/SelectioB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_HELP_BUTTON"
		end;

	XmDIALOG_LIST: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/SelectioB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_LIST"
		end;

	XmDIALOG_LIST_LABEL: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/SelectioB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_LIST_LABEL"
		end;

	XmDIALOG_OK_BUTTON: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/SelectioB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_OK_BUTTON"
		end;

	XmDIALOG_SELECTION_LABEL: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/SelectioB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_SELECTION_LABEL"
		end;

	XmDIALOG_SEPARATOR: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/SelectioB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_SEPARATOR"
		end;

	XmDIALOG_TEXT: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/SelectioB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_TEXT"
		end;

end -- class MEL_SELECTION_BOX_RESOURCES


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

