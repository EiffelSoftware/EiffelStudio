indexing

	description: 
		"Text Field defines";
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

end -- class MEL_TEXT_FIELD_RESOURCES


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

