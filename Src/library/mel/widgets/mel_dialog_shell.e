indexing

	description:
			"Dialog shell.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_DIALOG_SHELL

inherit

	MEL_TRANSIENT_SHELL
		redefine
			make
		end

creation
	make, 
	make_from_existing

feature -- Initilization

	make (a_name: STRING; a_parent: MEL_COMPOSITE) is
			-- Create a motif dialog shell.
		local
			widget_name: ANY
		do
			parent := a_parent;
			widget_name := a_name.to_c;
			check
				same_display_as_parent: screen.display = parent.screen.display
			end;
			screen_object := xm_create_dialog_shell 
					(a_parent.screen_object, $widget_name, default_pointer, 0);
			Mel_widgets.add_popup_shell (Current);
			set_default
		end;

feature {NONE} -- Implementation

	xm_create_dialog_shell (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
		external
			"C [macro <Xm/DialogS.h>] (Widget, String, ArgList, Cardinal): EIF_POINTER"
		alias
			"XmCreateDialogShell"
		end

end -- class MEL_DIALOG_SHEL

--|-----------------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1996, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-----------------------------------------------------------------------
