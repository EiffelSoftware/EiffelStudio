indexing

	description: 
		"Label resources.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_LABEL_RESOURCES

feature -- Implementation

	XmNaccelerator: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Label.h>] : EIF_POINTER"
		alias
			"XmNaccelerator"
		end;

	XmNacceleratorText: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Label.h>] : EIF_POINTER"
		alias
			"XmNacceleratorText"
		end;

	XmNalignment: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Label.h>] : EIF_POINTER"
		alias
			"XmNalignment"
		end;

	XmNlabelInsensitivePixmap: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Label.h>] : EIF_POINTER"
		alias
			"XmNlabelInsensitivePixmap"
		end;

	XmNlabelPixmap: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Label.h>] : EIF_POINTER"
		alias
			"XmNlabelPixmap"
		end;

	XmNlabelString: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Label.h>] : EIF_POINTER"
		alias
			"XmNlabelString"
		end;

	XmNlabelType: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Label.h>] : EIF_POINTER"
		alias
			"XmNlabelType"
		end;

	XmNmarginBottom: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Label.h>] : EIF_POINTER"
		alias
			"XmNmarginBottom"
		end;

	XmNmarginHeight: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Label.h>] : EIF_POINTER"
		alias
			"XmNmarginHeight"
		end;

	XmNmarginLeft: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Label.h>] : EIF_POINTER"
		alias
			"XmNmarginLeft"
		end;

	XmNmarginRight: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Label.h>] : EIF_POINTER"
		alias
			"XmNmarginRight"
		end;

	XmNmarginTop: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Label.h>] : EIF_POINTER"
		alias
			"XmNmarginTop"
		end;

	XmNmarginWidth: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Label.h>] : EIF_POINTER"
		alias
			"XmNmarginWidth"
		end;

	XmNmnemonic: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Label.h>] : EIF_POINTER"
		alias
			"XmNmnemonic"
		end;

	XmNmnemonicCharSet: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Label.h>] : EIF_POINTER"
		alias
			"XmNmnemonicCharSet"
		end;

	XmNrecomputeSize: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Label.h>] : EIF_POINTER"
		alias
			"XmNrecomputeSize"
		end;

	XmNstringDirection: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Label.h>] : EIF_POINTER"
		alias
			"XmNstringDirection"
		end;

	XmALIGNMENT_BEGINNING: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Label.h>] : EIF_INTEGER"
		alias
			"XmALIGNMENT_BEGINNING"
		end;

	XmALIGNMENT_CENTER: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Label.h>] : EIF_INTEGER"
		alias
			"XmALIGNMENT_CENTER"
		end;

	XmALIGNMENT_END: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Label.h>] : EIF_INTEGER"
		alias
			"XmALIGNMENT_END"
		end;

	XmPIXMAP: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Label.h>] : EIF_INTEGER"
		alias
			"XmPIXMAP"
		end;

	XmSTRING: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Label.h>] : EIF_INTEGER"
		alias
			"XmSTRING"
		end;

	XmSTRING_DIRECTION_L_TO_R: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Label.h>] : EIF_INTEGER"
		alias
			"XmSTRING_DIRECTION_L_TO_R"
		end;

	XmSTRING_DIRECTION_R_TO_L: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Label.h>] : EIF_INTEGER"
		alias
			"XmSTRING_DIRECTION_R_TO_L"
		end;

	XmSTRING_DIRECTION_DEFAULT: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/Label.h>] : EIF_INTEGER"
		alias
			"XmSTRING_DIRECTION_DEFAULT"
		end;

end -- class MEL_LABEL_RESOURCES


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

