indexing

	description:
			"Unmanaged MEL_FILE_SELECTION_BOX as a child of a MEL_DIALOG_SHELL.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_FILE_SELECTION_DIALOG

inherit

	MEL_FILE_SELECTION_BOX
		rename
			make as file_selection_make
		export
			{NONE} is_prompt_dialog, is_selection_dialog, is_command_dialog,
			is_file_selection_dialog,
			set_prompt_dialog, set_selection_dialog, set_command_dialog,
			set_file_selection_dialog
		redefine
			clean_up
		end;

creation
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE) is
			-- Create file selection dialog.
		local
			widget_name: ANY
		do
			parent := a_parent;
			widget_name := a_name.to_c;
			screen_object := xm_create_file_selection_dialog (a_parent.screen_object, $widget_name, default_pointer, 0);
			Mel_widgets.put (Current, screen_object);
			!! dialog_shell.make_from_existing (xt_parent (screen_object));
			create_file_selection_children;
			set_file_selection_dialog;
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

	xm_create_file_selection_dialog (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
	   external
			"C [macro <Xm/FileSB.h>] (Widget, String, ArgList, Cardinal): EIF_POINTER"
		alias
			"XmCreateFileSelectionDialog"
		end;

end -- class MEL_FILE_SELECTION_DIALOG

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
