indexing

	description: 
		"Motif File Selection Box resources.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_FILE_SELECTION_BOX_RESOURCES

feature -- Implementation

	XmNdirectory: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/FileSB.h>]: EIF_POINTER"
		alias
			"XmNdirectory"
		end;

	XmNdirectoryValid: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/FileSB.h>]: EIF_POINTER"
		alias
			"XmNdirectoryValid"
		end;

	XmNdirListItems: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/FileSB.h>]: EIF_POINTER"
		alias
			"XmNdirListItems"
		end;

	XmNdirListItemCount: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/FileSB.h>]: EIF_POINTER"
		alias
			"XmNdirListItemCount"
		end;

	XmNdirListLabelString: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/FileSB.h>]: EIF_POINTER"
		alias
			"XmNdirListLabelString"
		end;

	XmNdirMask: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/FileSB.h>]: EIF_POINTER"
		alias
			"XmNdirMask"
		end;

	XmNdirSearchProc: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/FileSB.h>]: EIF_POINTER"
		alias
			"XmNdirSearchProc"
		end;

	XmNdirSpec: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/FileSB.h>]: EIF_POINTER"
		alias
			"XmNdirSpec"
		end;

	XmNfileListItems: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/FileSB.h>]: EIF_POINTER"
		alias
			"XmNfileListItems"
		end;

	XmNfileListItemCount: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/FileSB.h>]: EIF_POINTER"
		alias
			"XmNfileListItemCount"
		end;

	XmNfileListLabelString: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/FileSB.h>]: EIF_POINTER"
		alias
			"XmNfileListLabelString"
		end;

	XmNfileSearchProc: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/FileSB.h>]: EIF_POINTER"
		alias
			"XmNfileSearchProc"
		end;

	XmNfileTypeMask: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/FileSB.h>]: EIF_POINTER"
		alias
			"XmNfileTypeMask"
		end;

	XmNfilterLabelString: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/FileSB.h>]: EIF_POINTER"
		alias
			"XmNfilterLabelString"
		end;

	XmNlistUpdated: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/FileSB.h>]: EIF_POINTER"
		alias
			"XmNlistUpdated"
		end;

	XmNnoMatchString: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/FileSB.h>]: EIF_POINTER"
		alias
			"XmNnoMatchString"
		end;

	XmNpattern: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/FileSB.h>]: EIF_POINTER"
		alias
			"XmNpattern"
		end;

	XmNqualifySearchDataProc: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/FileSB.h>]: EIF_POINTER"
		alias
			"XmNqualifySearchDataProc"
		end;

	XmFILE_DIRECTORY: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/FileSB.h>]: EIF_INTEGER"
		alias
			"XmFILE_DIRECTORY"
		end;

	XmFILE_REGULAR: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/FileSB.h>]: EIF_INTEGER"
		alias
			"XmFILE_REGULAR"
		end;

	XmFILE_ANY_TYPE: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/FileSB.h>]: EIF_INTEGER"
		alias
			"XmFILE_ANY_TYPE"
		end;

	XmDIALOG_DIR_LIST: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/SelectioB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_DIR_LIST"
		end;

	XmDIALOG_DIR_LIST_LABEL: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/SelectioB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_DIR_LIST_LABEL"
		end;

	XmDIALOG_FILTER_LABEL: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/SelectioB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_FILTER_LABEL"
		end;

	XmDIALOG_FILTER_TEXT: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/SelectioB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_FILTER_TEXT"
		end;

end -- class MEL_FILE_SELECTION_BOX_RESOURCES


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

