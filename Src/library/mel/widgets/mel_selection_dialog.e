indexing

	description:
			"Unmanaged MEL_SELECTION_BOX as a child of a MEL_DIALOG_SHELL.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_SELECTION_DIALOG

inherit

	MEL_SELECTION_BOX
		rename
			make as selection_make,
			make_no_auto_unmanage as selection_make_no_auto_unmanage
		export
			{NONE} is_prompt_dialog, is_selection_dialog, is_command_dialog,
			is_file_selection_dialog,
			set_prompt_dialog, set_selection_dialog, set_command_dialog,
			set_file_selection_dialog, selection_make, selection_make_no_auto_unmanage
		redefine
			clean_up, create_widget
		end;

creation
	make,
	make_no_auto_unmanage

feature {NONE} -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE) is
			-- Create a motif selection dialog.
		local
			widget_name: ANY
		do
			parent := a_parent;
			widget_name := a_name.to_c;
			create_widget (a_parent.screen_object, widget_name, True);
			Mel_widgets.put (Current, screen_object);
			!! dialog_shell.make_from_existing (xt_parent (screen_object));
			create_selection_children;
			set_default
		end;

	make_no_auto_unmanage (a_name: STRING; a_parent: MEL_COMPOSITE) is
			-- Create a motif selection dialog and set `auto_manage' to True.
		require
			a_name_exists: a_name /= Void;
			a_parent_exists: a_parent /= Void and then not a_parent.is_destroyed
		local
			widget_name: ANY
		do
			parent := a_parent;
			widget_name := a_name.to_c;
			create_widget (a_parent.screen_object, widget_name, False)
			!! dialog_shell.make_from_existing (xt_parent (screen_object));
			create_selection_children;
			set_default
		ensure
			exists: not is_destroyed;
			auto_unmanage: not auto_unmanage
		end;

	create_widget (p_so: POINTER; w_name: ANY; auto_manage_flag: BOOLEAN) is
			-- Create selection dialog with `auto_manage_flag'.
		do
			if auto_manage_flag then
				screen_object := xm_create_selection_dialog (p_so, $w_name, default_pointer, 0)
			else
				screen_object := xm_create_selection_dialog (p_so, $w_name, auto_unmanage_arg, 1)
			end
			Mel_widgets.put (Current, screen_object)
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

	xm_create_selection_dialog (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
	   external
			"C [macro <Xm/SelectioB.h>] (Widget, String, ArgList, Cardinal): EIF_POINTER"
		alias
			"XmCreateSelectionDialog"
		end;

end -- class MEL_SELECTION_DIALOG

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
