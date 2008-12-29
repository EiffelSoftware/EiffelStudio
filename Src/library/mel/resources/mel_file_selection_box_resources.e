note

	description: 
		"Motif File Selection Box resources."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_FILE_SELECTION_BOX_RESOURCES

feature -- Implementation

	XmNdirectory: POINTER
			-- Motif resource
		external
			"C [macro <Xm/FileSB.h>]: EIF_POINTER"
		alias
			"XmNdirectory"
		end;

	XmNdirectoryValid: POINTER
			-- Motif resource
		external
			"C [macro <Xm/FileSB.h>]: EIF_POINTER"
		alias
			"XmNdirectoryValid"
		end;

	XmNdirListItems: POINTER
			-- Motif resource
		external
			"C [macro <Xm/FileSB.h>]: EIF_POINTER"
		alias
			"XmNdirListItems"
		end;

	XmNdirListItemCount: POINTER
			-- Motif resource
		external
			"C [macro <Xm/FileSB.h>]: EIF_POINTER"
		alias
			"XmNdirListItemCount"
		end;

	XmNdirListLabelString: POINTER
			-- Motif resource
		external
			"C [macro <Xm/FileSB.h>]: EIF_POINTER"
		alias
			"XmNdirListLabelString"
		end;

	XmNdirMask: POINTER
			-- Motif resource
		external
			"C [macro <Xm/FileSB.h>]: EIF_POINTER"
		alias
			"XmNdirMask"
		end;

	XmNdirSearchProc: POINTER
			-- Motif resource
		external
			"C [macro <Xm/FileSB.h>]: EIF_POINTER"
		alias
			"XmNdirSearchProc"
		end;

	XmNdirSpec: POINTER
			-- Motif resource
		external
			"C [macro <Xm/FileSB.h>]: EIF_POINTER"
		alias
			"XmNdirSpec"
		end;

	XmNfileListItems: POINTER
			-- Motif resource
		external
			"C [macro <Xm/FileSB.h>]: EIF_POINTER"
		alias
			"XmNfileListItems"
		end;

	XmNfileListItemCount: POINTER
			-- Motif resource
		external
			"C [macro <Xm/FileSB.h>]: EIF_POINTER"
		alias
			"XmNfileListItemCount"
		end;

	XmNfileListLabelString: POINTER
			-- Motif resource
		external
			"C [macro <Xm/FileSB.h>]: EIF_POINTER"
		alias
			"XmNfileListLabelString"
		end;

	XmNfileSearchProc: POINTER
			-- Motif resource
		external
			"C [macro <Xm/FileSB.h>]: EIF_POINTER"
		alias
			"XmNfileSearchProc"
		end;

	XmNfileTypeMask: POINTER
			-- Motif resource
		external
			"C [macro <Xm/FileSB.h>]: EIF_POINTER"
		alias
			"XmNfileTypeMask"
		end;

	XmNfilterLabelString: POINTER
			-- Motif resource
		external
			"C [macro <Xm/FileSB.h>]: EIF_POINTER"
		alias
			"XmNfilterLabelString"
		end;

	XmNlistUpdated: POINTER
			-- Motif resource
		external
			"C [macro <Xm/FileSB.h>]: EIF_POINTER"
		alias
			"XmNlistUpdated"
		end;

	XmNnoMatchString: POINTER
			-- Motif resource
		external
			"C [macro <Xm/FileSB.h>]: EIF_POINTER"
		alias
			"XmNnoMatchString"
		end;

	XmNpattern: POINTER
			-- Motif resource
		external
			"C [macro <Xm/FileSB.h>]: EIF_POINTER"
		alias
			"XmNpattern"
		end;

	XmNqualifySearchDataProc: POINTER
			-- Motif resource
		external
			"C [macro <Xm/FileSB.h>]: EIF_POINTER"
		alias
			"XmNqualifySearchDataProc"
		end;

	XmFILE_DIRECTORY: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/FileSB.h>]: EIF_INTEGER"
		alias
			"XmFILE_DIRECTORY"
		end;

	XmFILE_REGULAR: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/FileSB.h>]: EIF_INTEGER"
		alias
			"XmFILE_REGULAR"
		end;

	XmFILE_ANY_TYPE: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/FileSB.h>]: EIF_INTEGER"
		alias
			"XmFILE_ANY_TYPE"
		end;

	XmDIALOG_DIR_LIST: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/SelectioB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_DIR_LIST"
		end;

	XmDIALOG_DIR_LIST_LABEL: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/SelectioB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_DIR_LIST_LABEL"
		end;

	XmDIALOG_FILTER_LABEL: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/SelectioB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_FILTER_LABEL"
		end;

	XmDIALOG_FILTER_TEXT: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/SelectioB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_FILTER_TEXT"
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




end -- class MEL_FILE_SELECTION_BOX_RESOURCES


