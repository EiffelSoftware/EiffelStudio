indexing

	description:
			"Unmanaged MEL_FILE_SELECTION_BOX as a child of a MEL_DIALOG_SHELL."
	legal: "See notice at end of class.";
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
			parent, created_dialog_automatically
		end;

create
	make

feature -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE) is
			-- Create file selection dialog.
		require
			name_exists: a_name /= Void
			parent_exists: a_parent /= Void and then not a_parent.is_destroyed
		local
			widget_name: ANY
		do
			widget_name := a_name.to_c;
			screen_object := xm_create_file_selection_dialog (a_parent.screen_object, $widget_name, default_pointer, 0);
			create parent.make_from_existing (xt_parent (screen_object), a_parent);
			Mel_widgets.add (Current);
			set_default
		ensure
			exists: not is_destroyed;
			parent_set: parent.parent = a_parent;
			name_set: name.is_equal (a_name)
		end;

feature -- Access

	parent: MEL_DIALOG_SHELL;
			-- Dialog shell

feature {NONE} -- Implementation

	created_dialog_automatically: BOOLEAN is
			-- Was the dialog shell created automatically?
		do
			Result := True
		end;

feature {NONE} -- Implementation

	xm_create_file_selection_dialog (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
	   external
			"C (Widget, String, ArgList, Cardinal): EIF_POINTER | <Xm/FileSB.h>"
		alias
			"XmCreateFileSelectionDialog"
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




end -- class MEL_FILE_SELECTION_DIALOG


