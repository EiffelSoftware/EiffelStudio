indexing

	description: 
		"Toggle Button resources.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_TOGGLE_BUTTON_RESOURCES

feature -- Implementation

	XmNfillOnSelect: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ToggleB.h>]: EIF_POINTER"
		alias
			"XmNfillOnSelect"
		end;

	XmNindicatorOn: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ToggleB.h>]: EIF_POINTER"
		alias
			"XmNindicatorOn"
		end;

	XmNindicatorSize: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ToggleB.h>]: EIF_POINTER"
		alias
			"XmNindicatorSize"
		end;

	XmNindicatorType: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ToggleB.h>]: EIF_POINTER"
		alias
			"XmNindicatorType"
		end;

	XmNselectColor: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ToggleB.h>]: EIF_POINTER"
		alias
			"XmNselectColor"
		end;

	XmNselectInsensitivePixmap: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ToggleB.h>]: EIF_POINTER"
		alias
			"XmNselectInsensitivePixmap"
		end;

	XmNselectPixmap: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ToggleB.h>]: EIF_POINTER"
		alias
			"XmNselectPixmap"
		end;

	XmNset: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ToggleB.h>]: EIF_POINTER"
		alias
			"XmNset"
		end;

	XmNspacing: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ToggleB.h>]: EIF_POINTER"
		alias
			"XmNspacing"
		end;

	XmNvisibleWhenOff: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ToggleB.h>]: EIF_POINTER"
		alias
			"XmNvisibleWhenOff"
		end;

	XmNarmCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ToggleB.h>]: EIF_POINTER"
		alias
			"XmNarmCallback"
		end;

	XmNdisarmCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ToggleB.h>]: EIF_POINTER"
		alias
			"XmNdisarmCallback"
		end;

	XmNvalueChangedCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/ToggleB.h>]: EIF_POINTER"
		alias
			"XmNvalueChangedCallback"
		end;

	XmN_OF_MANY: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/ToggleB.h>]: EIF_INTEGER"
		alias
			"XmN_OF_MANY"
		end;

	XmONE_OF_MANY: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/ToggleB.h>]: EIF_INTEGER"
		alias
			"XmONE_OF_MANY"
		end;

end -- class MEL_TOGGLE_BUTTON_RESOURCES


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

