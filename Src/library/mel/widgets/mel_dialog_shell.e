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

feature {MEL_COMPOSITE} -- Implementation

	remove_from_popup_list is
			-- Remove current shell from popup list in parent
		do
			parent.remove_popup_child (Current)
		end;

feature {NONE} -- Implementation

	xm_create_dialog_shell (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
		external
			"C (Widget, String, ArgList, Cardinal): EIF_POINTER | <Xm/DialogS.h>"
		alias
			"XmCreateDialogShell"
		end

end -- class MEL_DIALOG_SHEL


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

