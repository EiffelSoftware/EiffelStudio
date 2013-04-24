note

	description:
			"Unmanaged MEL_MESSAGE_BOX as a child of MEL_DIALOG_SHELL."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_MESSAGE_DIALOG 

inherit

	MEL_MESSAGE_BOX
		rename
			make as message_make,
			make_no_auto_unmanage as message_make_no_auto_unmanage
		export
			{NONE} is_error_dialog, is_information_dialog, is_message_dialog, 
			is_question_dialog, is_template_dialog, is_warning_dialog,
			is_working_dialog,
			set_error_dialog, set_information_dialog, set_message_dialog, 
			set_question_dialog, set_template_dialog, set_warning_dialog, 
			set_working_dialog, message_make, message_make_no_auto_unmanage
		redefine
			create_widget, parent, created_dialog_automatically
		end;

create
	make,
	make_no_auto_unmanage

feature -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE)
			-- Create a motif message dialog.
		require
			name_exists: a_name /= Void
			parent_exists: a_parent /= Void and then not a_parent.is_destroyed
		local
			widget_name: ANY
		do
			widget_name := a_name.to_c;
			create_widget (a_parent.screen_object, widget_name, True);
			create parent.make_from_existing (xt_parent (screen_object), a_parent);
			Mel_widgets.add (Current);
			set_default
		ensure
			exists: not is_destroyed;
			parent_set: parent.parent = a_parent;
			name_set: name.is_equal (a_name)
		end;

	make_no_auto_unmanage (a_name: STRING; a_parent: MEL_COMPOSITE)
			-- Create a motif message dialog and set `auto_manage' to True.
		require
			name_exists: a_name /= Void
			parent_exists: a_parent /= Void and then not a_parent.is_destroyed
		local
			widget_name: ANY
		do
			widget_name := a_name.to_c;
			create_widget (a_parent.screen_object, widget_name, False)
			create parent.make_from_existing (xt_parent (screen_object), a_parent);
			Mel_widgets.add (Current);
			set_default
		ensure
			exists: not is_destroyed;
			auto_unmanage: not auto_unmanage;
			parent_set: parent.parent = a_parent;
			name_set: name.is_equal (a_name)
		end;

feature {NONE} -- Initialization

	create_widget (p_so: POINTER; w_name: ANY; auto_manage_flag: BOOLEAN)
			-- Create message dialog with `auto_manage_flag'.
		do
			if auto_manage_flag then
				screen_object := xm_create_message_dialog (p_so, $w_name, default_pointer, 0)
			else
				screen_object := xm_create_message_dialog (p_so, $w_name, auto_unmanage_arg, 1)
			end
		end;

feature -- Access

	parent: MEL_DIALOG_SHELL;
			-- The dialog shell

feature {NONE} -- Implementation

	created_dialog_automatically: BOOLEAN
			-- Was the dialog shell created automatically?
		do
			Result := True
		end;

feature {NONE} -- Implementation

	xm_create_message_dialog (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER
		external
			"C (Widget, String, ArgList, Cardinal): EIF_POINTER | <Xm/MessageB.h>"
		alias
			"XmCreateMessageDialog"
		end;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class MEL_MESSAGE_DIALOG


