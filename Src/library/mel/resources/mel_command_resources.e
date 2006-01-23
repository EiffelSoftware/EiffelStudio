indexing

	description: 
		"Motif Command resources."
	legal: "See notice at end of class.";
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class MEL_COMMAND_RESOURCES


