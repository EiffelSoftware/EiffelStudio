indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class FILE_SELEC_O 

inherit

	FILE_SELEC_I
		export
			{NONE} all
		end;

	TERMINAL_O
		undefine
			make
		end

creation

	make

feature -- Creation

	make (a_file_selection: FILE_SELEC) is
			-- Create a motif file selection.
		do
			screen_object := create_file_box (a_file_selection.identifier,
			   a_file_selection.parent)
		end;

feature -- Visibility

	hide_help_button is
			-- Make help button invisible.
		do
			help_button.unmanage;
		end;

	hide_cancel_button is
			-- Make cancel button invisible.
		do
			cancel_button.unmanage
		end;

	hide_ok_button is
			-- Make ok button invisible.
		do
			ok_button.unmanage
		end;

	show_cancel_button is
			-- Make cancel button visible.
		do
			cancel_button.manage
		end;

	show_ok_button is
			-- Make ok button visible.
		do
			ok_button.manage
		end;

	show_help_button is
			-- Make help button visible.
		do
			help_button.manage;
		end;

feature -- Callbacks

	add_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- cancel button is activated.
		require else
			not_a_command_void: not (a_command = Void)
		do
			cancel_button.add_activate_action (a_command, argument);
		end;

	add_help_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- help button is activated.
		require else
			not_a_command_void: not (a_command = Void)
		do
			help_button.add_activate_action (a_command, argument);
		end;

	add_ok_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- ok button is activated.
		require else
			not_a_command_void: not (a_command = Void)
		do
			ok_button.add_activate_action (a_command, argument);
			file_field.add_activate_action (a_command, argument);
		end;

	remove_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- cancel button is activated.
		require else
			not_a_command_void: not (a_command = Void)
		do
			cancel_button.remove_activate_action (a_command, argument);
		end;

	remove_help_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- help button is activated.
		require else
			not_a_command_void: not (a_command = Void)
		do
			help_button.remove_activate_action (a_command, argument);
		end;

	remove_ok_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- ok button is activated.
		require else
			not_a_command_void: not (a_command = Void)
		do
			ok_button.remove_activate_action (a_command, argument);
		end;

feature -- Text

	set_directory (a_directory_name: STRING) is
			-- Set base directory used in determining files and directories
		   -- to be displayed to `a_directory_name'.
		require else
			not_a_directory_name_void: not (a_directory_name = Void)
		do
			directory_field.set_text (a_directory_name)
		end;

	set_cancel_label (a_label: STRING) is
			-- Set `a_label' as label for cancel button,
			-- by default this label is `cancel'.
		require else
			not_label_void: not (a_label = Void)
		do
			cancel_button.set_text (a_label)
		end;

	set_help_label (a_label: STRING) is
			-- Set `a_label' as label for help button,
			-- by default this label is `help'.
		require else
			not_label_void: not (a_label = Void)
		do
			help_button.set_text (a_label);
		end;

	set_ok_label (a_label: STRING) is
			-- Set `a_label' as label for ok button,
			-- by default this label is `ok'.
		require else
			not_label_void: not (a_label = Void)
		do
			ok_button.set_text (a_label);
		end;

	set_file_list_label (a_label: STRING) is
			-- Set `a_label' as file list label,
			-- by default this label is `Files'.
		require else
			a_label_not_void: not (a_label = Void)
		do
			file_label.set_text (a_label)
		end;
 
	set_dir_list_label (a_label: STRING) is
			-- Set `a_label' as dir list label,
			-- by default this label is `Directories'.
		require else
			a_label_not_void: not (a_label = Void)
		do
			directory_label.set_text (a_label)
		end;

	selected_file: STRING is
			-- Current selected file
		do
			!!Result.make (0);
			Result.append (directory_field.text);
			Result.append ("/");
			Result.append (file_field.text)
		end;

	directory: STRING is
		do
			Result := directory_field.text
		end;

feature {NONE} -- EiffelVision implementation

	file_label, directory_label: LABEL;
	file_field, directory_field: TEXT_FIELD;
	ok_button, help_button, cancel_button: PUSH_B;
	button_area: ROW_COLUMN;
	message_form: FORM;

	create_file_box (a_name: STRING; a_parent: COMPOSITE): POINTER is
		do
			!!message_form.make (a_name, a_parent);
			!!button_area.make ("", message_form);
			button_area.set_row_layout;
			button_area.set_same_size;
			!!file_field.make ("", message_form);
			!!directory_field.make ("", message_form);
			!!file_label.make ("", message_form);	
			!!directory_label.make ("", message_form);	
			!!ok_button.make ("ok", button_area);
			!!help_button.make ("help", button_area);
			!!cancel_button.make ("cancel", button_area);

			file_label.set_text ("File:");
			directory_label.set_text ("Directory:");

			message_form.attach_top (directory_label, 5);	
			message_form.attach_left (directory_label, 5);	
			message_form.attach_bottom_widget (directory_field, directory_label, 5);
			message_form.attach_left (directory_field, 15);	
			message_form.attach_right (directory_field, 0);	
			message_form.attach_bottom_widget (file_label, directory_field, 5);	
			message_form.attach_left (file_label, 5);	
			message_form.attach_bottom_widget (file_field, file_label, 5);
			message_form.attach_left (file_field, 15);	
			message_form.attach_right (file_field, 0);	
			message_form.attach_bottom_widget (button_area, file_field, 5);
			message_form.attach_bottom (button_area, 5);	
			message_form.attach_left (button_area, 5);	
			message_form.attach_right (button_area, 5);	
			Result := message_form.implementation.screen_object
		end;

feature -- Not implemented

	add_filter_action (a_command: COMMAND; argument: ANY) is
		do
		end;
		
	filter: STRING is
		do
		end;

	set_filter (a_filter: STRING) is
		do
		end;

	is_dir_valid: BOOLEAN is
		do
		end;

	is_list_updated: BOOLEAN is
		do
		end;

	pattern: STRING is
		do
		end;

	set_pattern (a_pattern: STRING) is
		do
		end;

	set_filter_label (a_label: STRING) is
		do
		end;

	file_list: LINKED_LIST [STRING] is
		do
		end;

	dir_list: LINKED_LIST [STRING] is
		do
		end;

	dir_count: INTEGER is
		do
		end;

	file_count: INTEGER is
		do
		end;

	remove_filter_action (a_command: COMMAND; argument: ANY) is
		do
		end;

	show_filter_button is
		do
		end;

	hide_filter_button is
		do
		end;

feature
	
 set_file_list_width (new_width: INTEGER) is
  do
  end;


 hide_file_selection_list is
  do
  end;

 hide_file_selection_label is
  do
  end;
   

 show_file_selection_label is
  do
  end;

 show_file_selection_list is
  do
  end;

 set_file_sel_mask(choice: INTEGER) is
  do
  end;

 set_filter_default is
  do
  end;

  

 set_directory_selection is
            -- Sets selection to directories only.
  do
  end;

 set_file_selection is
   -- Sets selection to files (default value). 
  do
  end;

 set_all_selection is
   -- Sets selection to files and directories.
  do
  end;
   

end



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
