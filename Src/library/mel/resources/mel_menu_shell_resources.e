indexing

	description: 
		"Menu Shell resources."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_MENU_SHELL_RESOURCES

feature -- Implementation

	XmNbuttonFontList: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/MenuShell.h>]: EIF_POINTER"
		alias
			"XmNbuttonFontList"
		end;

	XmNdefaultFontList: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/MenuShell.h>]: EIF_POINTER"
		alias
			"XmNdefaultFontList"
		end;

	XmNlabelFontList: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/MenuShell.h>]: EIF_POINTER"
		alias
			"XmNlabelFontList"
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




end -- class MEL_MENU_SHELL_RESOURCES


