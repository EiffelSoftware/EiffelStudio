indexing

	description: 
		"Motif Command resources.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_COMMAND_RESOURCES

feature -- Implementation

	XmNcommand: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Command.h>]: EIF_POINTER"
		alias
			"XmNcommand"
		end;

	XmNhistoryItems: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Command.h>]: EIF_POINTER"
		alias
			"XmNhistoryItems"
		end;

	XmNhistoryItemCount: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Command.h>]: EIF_POINTER"
		alias
			"XmNhistoryItemCount"
		end;

	XmNhistoryMaxItems: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Command.h>]: EIF_POINTER"
		alias
			"XmNhistoryMaxItems"
		end;

	XmNhistoryVisibleItemCount: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Command.h>]: EIF_POINTER"
		alias
			"XmNhistoryVisibleItemCount"
		end;

	XmNpromptString: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Command.h>]: EIF_POINTER"
		alias
			"XmNpromptString"
		end;

	XmNcommandEnteredCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Command.h>]: EIF_POINTER"
		alias
			"XmNcommandEnteredCallback"
		end;

	XmNcommandChangedCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/Command.h>]: EIF_POINTER"
		alias
			"XmNcommandChangedCallback"
		end;

end -- class MEL_COMMAND_RESOURCES


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

