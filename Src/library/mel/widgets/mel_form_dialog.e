indexing

	description:
			"Unmanaged MEL_FORM as child of a MEL_DIALOG_SHELL.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_FORM_DIALOG

inherit

	MEL_FORM
		rename
			make as form_make,
			make_no_auto_unmanage as form_make_no_auto_unmanage
		export
			{NONE} form_make, form_make_no_auto_unmanage
		redefine
			clean_up, create_widget
		end

creation
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE) is
			-- Create a motif form dialog.
		do
			form_make (a_name, a_parent, False);
		end;

	make_no_auto_unmanage (a_name: STRING; a_parent: MEL_COMPOSITE) is
			-- Create a motif form dialog and set `auto_unmanage' to False.
		do
			form_make_no_auto_unmanage (a_name, a_parent, False);
		end;

	create_widget (p_so: POINTER; w_name: ANY; auto_manage_flag: BOOLEAN) is
			-- Create bulletin with `auto_manage_flag'.
		do
			if auto_manage_flag then
				screen_object := xm_create_form_dialog (p_so, $w_name, default_pointer, 0)
			else
				screen_object := xm_create_form_dialog (p_so, $w_name, auto_unmanage_arg, 1)
			end;
			Mel_widgets.put (Current, screen_object);
			!! dialog_shell.make_from_existing (xt_parent (screen_object))
		end;

feature -- Access

	dialog_shell: MEL_DIALOG_SHELL;
			-- Dialog shell

feature -- Removal

	clean_up is
			-- Destroy the widget.
		do
			object_clean_up;
			dialog_shell.object_clean_up
		end;

feature {NONE} -- Implementation

	xm_create_form_dialog (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
		external
			"C [macro <Xm/Form.h>] (Widget, String, ArgList, Cardinal): EIF_POINTER"
		alias
			"XmCreateFormDialog"
		end;

end -- class MEL_FORM_DIALOG

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
