indexing

	description:
			"Unmanaged MEL_SELECTION_BOX as a child of a MEL_DIALOG_SHELL.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_PROMPT_DIALOG

inherit

	MEL_SELECTION_DIALOG
		export
			{NONE} is_prompt_dialog, is_selection_dialog, is_command_dialog,
			is_file_selection_dialog, list_label_string, list_visible_item_count,
			set_prompt_dialog, set_selection_dialog, set_command_dialog,
			set_file_selection_dialog, set_list_label_string,
			set_list_visible_item_count
		redefine
			create_widget
		end;

creation
	make,
	make_no_auto_unmanage

feature {NONE} -- Initialization

	create_widget (p_so: POINTER; w_name: ANY; auto_manage_flag: BOOLEAN) is
			-- Create a motif prompt dialog with `auto_manage_flag'.
		do
			if auto_manage_flag then
				screen_object := xm_create_prompt_dialog (p_so, $w_name, default_pointer, 0)
			else
				screen_object := xm_create_prompt_dialog (p_so, $w_name, auto_unmanage_arg, 1)
			end
		end;

feature {NONE} -- Implementation

	xm_create_prompt_dialog (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
	   external
			"C [macro <Xm/SelectioB.h>] (Widget, String, ArgList, Cardinal): EIF_POINTER"
		alias
			"XmCreatePromptDialog"
		end;

end -- class MEL_PROMPT_DIALOG

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
