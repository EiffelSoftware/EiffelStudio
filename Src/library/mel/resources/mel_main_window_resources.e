indexing

	description: 
		"Main Window resources.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_MAIN_WINDOW_RESOURCES

feature -- Implementation

	XmNcommandWindow: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/MainW.h>]: EIF_POINTER"
		alias
			"XmNcommandWindow"
		end;

	XmNcommandWindowLocation: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/MainW.h>]: EIF_POINTER"
		alias
			"XmNcommandWindowLocation"
		end;

	XmNmainWindowMarginHeight: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/MainW.h>]: EIF_POINTER"
		alias
			"XmNmainWindowMarginHeight"
		end;

	XmNmainWindowMarginWidth: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/MainW.h>]: EIF_POINTER"
		alias
			"XmNmainWindowMarginWidth"
		end;

	XmNmenuBar: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/MainW.h>]: EIF_POINTER"
		alias
			"XmNmenuBar"
		end;

	XmNmessageWindow: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/MainW.h>]: EIF_POINTER"
		alias
			"XmNmessageWindow"
		end;

	XmNshowSeparator: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/MainW.h>]: EIF_POINTER"
		alias
			"XmNshowSeparator"
		end;

	XmCOMMAND_ABOVE_WORKSPACE: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/MainW.h>]: EIF_INTEGER"
		alias
			"XmCOMMAND_ABOVE_WORKSPACE"
		end;

	XmCOMMAND_BELOW_WORKSPACE: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/MainW.h>]: EIF_INTEGER"
		alias
			"XmCOMMAND_BELOW_WORKSPACE"
		end;

end -- class MEL_MAIN_WINDOW_RESOURCES


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

