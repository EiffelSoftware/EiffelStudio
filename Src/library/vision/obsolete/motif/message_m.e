
-- MESSAGE_M: implementation of message box.

indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class MESSAGE_M

inherit

	MESSAGE_R_M
		export
			{NONE} all
		end;

	MESSAGE_I
		export
			{NONE} all
		end;

	TERMINAL_M
		rename 
			xt_parent as t_xt_parent,
			clean_up as terminal_clean_up
		undefine
			make
		end

	TERMINAL_M
		rename 
			xt_parent as t_xt_parent
		undefine
			make
		redefine
			clean_up
		select
			clean_up
		end

creation

	make

feature {NONE} -- Creation

	make (a_message: MESSAGE; man: BOOLEAN) is
			-- Create a motif message box.
		local
			ext_name: ANY
		do
			widget_index := widget_manager.last_inserted_position;
			ext_name := a_message.identifier.to_c;
			screen_object := create_message ($ext_name,
				parent_screen_object (a_message, widget_index),
				man);
		end

feature {NONE}

	help_actions: EVENT_HAND_M;
			-- An event handler to manage call-backs when help button
			-- is activated

	cancel_actions: EVENT_HAND_M;
			-- An event handler to manage call-backs when cancel button
			-- is activated

	ok_actions: EVENT_HAND_M;
			-- An event handler to manage call-backs when ok button
			-- is activated

	hide_help_button is
			-- Make help button invisible.
		do
			xt_unmanage_child (xm_message_box_get_child
				(screen_object, MDIALOG_HELP_BUTTON))
		end;

	show_help_button is
			-- Make help button visible.
		do
			xt_manage_child (xm_message_box_get_child
				(screen_object, MDIALOG_HELP_BUTTON))
		end;

	clean_up is
		do
			terminal_clean_up;
			if cancel_actions /= Void then
				cancel_actions.free_cdfd
			end;
			if help_actions /= Void then
				help_actions.free_cdfd
			end;
			if ok_actions /= Void then
				ok_actions.free_cdfd
			end
		end;


feature 

	add_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- cancel button is activated.
		require else
			not_a_command_void: not (a_command = Void)
		do
			if (cancel_actions = Void) then
				!! cancel_actions.make (screen_object, Mcancel, widget_oui)
			end;
			cancel_actions.add (a_command, argument)
		end;

	add_help_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- help button is activated.
		require else
			not_a_command_void: not (a_command = Void)
		do
			if (help_actions = Void) then
				!! help_actions.make (screen_object, Mhelp, widget_oui)
			end;
			help_actions.add (a_command, argument)
		end;

	add_ok_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- ok button is activated.
		require else
			not_a_command_void: not (a_command = Void)
		do
			if (ok_actions = Void) then
				!! ok_actions.make (screen_object, Mok, widget_oui)
			end;
			ok_actions.add (a_command, argument)
		end;

	hide_cancel_button is
			-- Make cancel button invisible.
		do
			xt_unmanage_child (xm_message_box_get_child (screen_object, MDIALOG_CANCEL_BUTTON))
		end;

	hide_ok_button is
			-- Make ok button invisible.
		do
			xt_unmanage_child (xm_message_box_get_child (screen_object, MDIALOG_OK_BUTTON))
		end;

	remove_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- cancel button is activated.
		require else
			not_a_command_void: not (a_command = Void)
		do
			cancel_actions.remove (a_command, argument)
		end;

	remove_help_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- help button is activated.
		require else
			not_a_command_void: not (a_command = Void)
		do
			help_actions.remove (a_command, argument)
		end;

	remove_ok_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- ok button is activated.
		require else
			not_a_command_void: not (a_command = Void)
		do
			ok_actions.remove (a_command, argument)
		end;

	set_cancel_label (a_label: STRING) is
			-- Set `a_label' as label for cancel button,
			-- by default this label is `cancel'.
		require else
			not_label_void: not (a_label = Void)
		local
			ext_name, ext_name_label: ANY
		do
			ext_name_label := a_label.to_c;
			ext_name := McancelLabelString.to_c;
			to_left_xm_string (screen_object, ext_name_label, ext_name)
		end;

	set_center_alignment is
			-- Set message alignment to center.
		local
			ext_name: ANY
		do
			ext_name := MmessageAlignment.to_c;
			set_unsigned_char (screen_object, MALIGNMENT_CENTER, $ext_name)
		end;

	set_end_alignment is
			-- Set message alignment to end.
		local
			ext_name: ANY
		do
			ext_name := MmessageAlignment.to_c;
			set_unsigned_char (screen_object, MALIGNMENT_END, $ext_name)
		end;

	set_help_label (a_label: STRING) is
			-- Set `a_label' as label for help button,
			-- by default this label is `help'.
		require else
			not_label_void: not (a_label = Void)
		local
			ext_name, ext_name_label: ANY
		do
			ext_name := MhelpLabelString.to_c;
			ext_name_label := a_label.to_c;
			to_left_xm_string (screen_object, ext_name_label, ext_name)
		end;

	set_message (a_message: STRING) is
			-- Set `a_message' as message.
		require else
			not_message_void: not (a_message = Void)
		local
			ext_name, ext_name_mess: ANY
		do
			ext_name := MmessageString.to_c;
			ext_name_mess := a_message.to_c;
			to_left_xm_string (screen_object, ext_name_mess, ext_name)
		end;

	set_ok_label (a_label: STRING) is
			-- Set `a_label' as label for ok button,
			-- by default this label is `ok'.
		require else
			not_label_void: not (a_label = Void)
		local
			ext_name, ext_name_label: ANY
		do
			ext_name := MokLabelString.to_c;
			ext_name_label := a_label.to_c;
			to_left_xm_string (screen_object, ext_name_label, ext_name)
		end;

	set_start_alignment is
			-- Set message alignment to beginning.
		local
			ext_name: ANY
		do
			ext_name := MmessageAlignment.to_c;
			set_unsigned_char (screen_object, MALIGNMENT_BEGINNING,
					$ext_name)
		end;

	show_cancel_button is
			-- Make cancel button visible.
		do
			xt_manage_child (xm_message_box_get_child (screen_object, MDIALOG_CANCEL_BUTTON))
		end;

	show_ok_button is
			-- Make ok button visible.
		do
			xt_manage_child (xm_message_box_get_child (screen_object, MDIALOG_OK_BUTTON))
		end

feature {NONE} -- External features

	to_left_xm_string (scr_obj: POINTER; name1, name2: ANY) is
		external
			"C"
		end;

	xm_message_box_get_child (scr_obj: POINTER; value: INTEGER): POINTER is
		external
			"C"
		end;

	create_message (i_name: ANY; scr_obj: POINTER;
			man: BOOLEAN): POINTER is
		external
			"C"
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
