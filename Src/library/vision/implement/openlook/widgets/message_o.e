
indexing
	copyright: "See notice at end of class";

class MESSAGE_O

inherit

	MESSAGE_I
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

	make (a_message: MESSAGE) is
			-- Create a message box.
		do
			screen_object :=
				create_message_box (a_message.identifier, a_message.parent);
		end

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

	set_message (a_message: STRING) is
			-- Set `a_message' as message.
		require else
			not_message_void: not (a_message = Void)
		do
			message_label.set_text (a_message)
		end;

	set_ok_label (a_label: STRING) is
			-- Set `a_label' as label for ok button,
			-- by default this label is `ok'.
		require else
			not_label_void: not (a_label = Void)
		do
			ok_button.set_text (a_label);
		end;

feature -- Alignment

	set_center_alignment is
			-- Set message alignment to center.
		do
			message_label.set_center_alignment;
		end;

	set_end_alignment is
			-- Set message alignment to end.
		do
		end;

	set_start_alignment is
			-- Set message alignment to beginning.
		do
			 message_label.set_left_alignment;
		end;

feature {NONE} -- EiffelVision implemetation

	message_label: LABEL;
	ok_button, help_button, cancel_button: PUSH_B;
	button_area: ROW_COLUMN;
	message_form: FORM;

	create_message_box (a_name: STRING; a_parent: COMPOSITE): POINTER is
		do
			!!message_form.make (a_name, a_parent);
			!!button_area.make ("ButtonArea", message_form);
			button_area.set_row_layout;
			button_area.set_same_size;
			!!message_label.make ("", message_form);	
			!!ok_button.make ("Ok", button_area);
			!!help_button.make ("Help", button_area);
			!!cancel_button.make ("Cancel", button_area);

			message_form.attach_top (message_label, 5);
			message_form.attach_right (message_label, 5);
			message_form.attach_left (message_label, 5);
			message_form.attach_bottom_widget (button_area, message_label, 5);
			message_form.attach_bottom (button_area, 5);	
			message_form.attach_left (button_area, 5);	
			message_form.attach_right (button_area, 5);	
			Result := message_form.implementation.screen_object;
		end;

end



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
