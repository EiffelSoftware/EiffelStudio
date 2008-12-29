note

	description: 
		"Selection Box resources."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_SELECTION_BOX_RESOURCES

feature -- Implementation

	XmNapplyLabelString: POINTER
			-- Motif resource
		external
			"C [macro <Xm/SelectioB.h>]: EIF_POINTER"
		alias
			"XmNapplyLabelString"
		end;

	XmNcancelLabelString: POINTER
			-- Motif resource
		external
			"C [macro <Xm/SelectioB.h>]: EIF_POINTER"
		alias
			"XmNcancelLabelString"
		end;

	XmNchildPlacement: POINTER
			-- Motif resource
		external
			"C [macro <Xm/SelectioB.h>]: EIF_POINTER"
		alias
			"XmNchildPlacement"
		end;

	XmNdialogType: POINTER
			-- Motif resource
		external
			"C [macro <Xm/SelectioB.h>]: EIF_POINTER"
		alias
			"XmNdialogType"
		end;

	XmNhelpLabelString: POINTER
			-- Motif resource
		external
			"C [macro <Xm/SelectioB.h>]: EIF_POINTER"
		alias
			"XmNhelpLabelString"
		end;

	XmNlistItemCount: POINTER
			-- Motif resource
		external
			"C [macro <Xm/SelectioB.h>]: EIF_POINTER"
		alias
			"XmNlistItemCount"
		end;

	XmNlistItems: POINTER
			-- Motif resource
		external
			"C [macro <Xm/SelectioB.h>]: EIF_POINTER"
		alias
			"XmNlistItems"
		end;

	XmNlistLabelString: POINTER
			-- Motif resource
		external
			"C [macro <Xm/SelectioB.h>]: EIF_POINTER"
		alias
			"XmNlistLabelString"
		end;

	XmNlistVisibleItemCount: POINTER
			-- Motif resource
		external
			"C [macro <Xm/SelectioB.h>]: EIF_POINTER"
		alias
			"XmNlistVisibleItemCount"
		end;

	XmNminimizeButtons: POINTER
			-- Motif resource
		external
			"C [macro <Xm/SelectioB.h>]: EIF_POINTER"
		alias
			"XmNminimizeButtons"
		end;

	XmNmustMatch: POINTER
			-- Motif resource
		external
			"C [macro <Xm/SelectioB.h>]: EIF_POINTER"
		alias
			"XmNmustMatch"
		end;

	XmNokLabelString: POINTER
			-- Motif resource
		external
			"C [macro <Xm/SelectioB.h>]: EIF_POINTER"
		alias
			"XmNokLabelString"
		end;

	XmNselectionLabelString: POINTER
			-- Motif resource
		external
			"C [macro <Xm/SelectioB.h>]: EIF_POINTER"
		alias
			"XmNselectionLabelString"
		end;

	XmNtextAccelerators: POINTER
			-- Motif resource
		external
			"C [macro <Xm/SelectioB.h>]: EIF_POINTER"
		alias
			"XmNtextAccelerators"
		end;

	XmNtextColumns: POINTER
			-- Motif resource
		external
			"C [macro <Xm/SelectioB.h>]: EIF_POINTER"
		alias
			"XmNtextColumns"
		end;

	XmNtextString: POINTER
			-- Motif resource
		external
			"C [macro <Xm/SelectioB.h>]: EIF_POINTER"
		alias
			"XmNtextString"
		end;

	XmNapplyCallback: POINTER
			-- Motif resource
		external
			"C [macro <Xm/SelectioB.h>]: EIF_POINTER"
		alias
			"XmNapplyCallback"
		end;

	XmNcancelCallback: POINTER
			-- Motif resource
		external
			"C [macro <Xm/SelectioB.h>]: EIF_POINTER"
		alias
			"XmNcancelCallback"
		end;

	XmNnoMatchCallback: POINTER
			-- Motif resource
		external
			"C [macro <Xm/SelectioB.h>]: EIF_POINTER"
		alias
			"XmNnoMatchCallback"
		end;

	XmNokCallback: POINTER
			-- Motif resource
		external
			"C [macro <Xm/SelectioB.h>]: EIF_POINTER"
		alias
			"XmNokCallback"
		end;

	XmPLACE_ABOVE_SELECTION: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/SelectioB.h>]: EIF_INTEGER"
		alias
			"XmPLACE_ABOVE_SELECTION"
		end;

	XmPLACE_BELOW_SELECTION: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/SelectioB.h>]: EIF_INTEGER"
		alias
			"XmPLACE_BELOW_SELECTION"
		end;

	XmPLACE_TOP: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/SelectioB.h>]: EIF_INTEGER"
		alias
			"XmPLACE_TOP"
		end;

	XmDIALOG_PROMPT: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/SelectioB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_PROMPT"
		end;

	XmDIALOG_SELECTION: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/SelectioB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_SELECTION"
		end;

	XmDIALOG_COMMAND: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/SelectioB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_COMMAND"
		end;

	XmDIALOG_FILE_SELECTION: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/SelectioB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_FILE_SELECTION"
		end;

	XmDIALOG_APPLY_BUTTON: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/SelectioB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_APPLY_BUTTON"
		end;

	XmDIALOG_CANCEL_BUTTON: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/SelectioB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_CANCEL_BUTTON"
		end;

	XmDIALOG_DEFAULT_BUTTON: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/SelectioB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_DEFAULT_BUTTON"
		end;

	XmDIALOG_HELP_BUTTON: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/SelectioB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_HELP_BUTTON"
		end;

	XmDIALOG_LIST: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/SelectioB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_LIST"
		end;

	XmDIALOG_LIST_LABEL: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/SelectioB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_LIST_LABEL"
		end;

	XmDIALOG_OK_BUTTON: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/SelectioB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_OK_BUTTON"
		end;

	XmDIALOG_SELECTION_LABEL: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/SelectioB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_SELECTION_LABEL"
		end;

	XmDIALOG_SEPARATOR: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/SelectioB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_SEPARATOR"
		end;

	XmDIALOG_TEXT: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/SelectioB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_TEXT"
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




end -- class MEL_SELECTION_BOX_RESOURCES


