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
			create_widget, parent, created_dialog_automatically
		end;

creation
	make,
	make_no_auto_unmanage

feature -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE) is
			-- Create a motif selection dialog.
		require
			name_exists: a_name /= Void;
			parent_exists: a_parent /= Void and then not a_parent.is_destroyed
		local
			widget_name: ANY
		do
			widget_name := a_name.to_c;
			create_widget (a_parent.screen_object, widget_name, True);
			!! parent.make_from_existing (xt_parent (screen_object), a_parent);
			Mel_widgets.add (Current);
			set_default
		ensure
			exists: not is_destroyed;
			parent_set: parent.parent = a_parent;
			name_set: name.is_equal (a_name)
		end;

	make_no_auto_unmanage (a_name: STRING; a_parent: MEL_COMPOSITE) is
			-- Create a motif selection dialog and set `auto_manage' to True.
		require
			name_exists: a_name /= Void;
			parent_exists: a_parent /= Void and then not a_parent.is_destroyed
		local
			widget_name: ANY
		do
			widget_name := a_name.to_c;
			create_widget (a_parent.screen_object, widget_name, False);
			!! parent.make_from_existing (xt_parent (screen_object), a_parent);
			Mel_widgets.add (Current);
			set_default
		ensure
			exists: not is_destroyed;
			parent_set: parent.parent = a_parent;
			name_set: name.is_equal (a_name)
			auto_unmanage: not auto_unmanage
		end;

feature {NONE} -- Initialization

	create_widget (p_so: POINTER; w_name: ANY; auto_manage_flag: BOOLEAN) is
			-- Create selection dialog with `auto_manage_flag'.
		do
			if auto_manage_flag then
				screen_object := xm_create_selection_dialog (p_so, $w_name, default_pointer, 0)
			else
				screen_object := xm_create_selection_dialog (p_so, $w_name, auto_unmanage_arg, 1)
			end
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

	xm_create_selection_dialog (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
	   external
			"C (Widget, String, ArgList, Cardinal): EIF_POINTER | <Xm/SelectioB.h>"
		alias
			"XmCreateSelectionDialog"
		end;

end -- class MEL_SELECTION_DIALOG


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

