
indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class PROMPT_M

inherit

	PROMPT_I;

	TERMINAL_M
		export
			{NONE} all
		undefine
			make
		end;

	PROMPT_R_M
		export
			{NONE} all
		end

creation

	make

feature

	make (a_prompt: PROMPT) is
			-- Create a motif prompt.
		local
			ext_name: ANY
		do
			ext_name := a_prompt.identifier.to_c;
			screen_object := create_prompt ($ext_name,
				a_prompt.parent.implementation.screen_object)
		end;

feature 

	add_apply_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- apply button is activated.
		require else
			not_a_command_void: not (a_command = Void)
		do
			if (apply_actions = Void) then
				!! apply_actions.make (screen_object, Mapply, widget_oui)
			end;
			apply_actions.add (a_command, argument)
		end;

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

feature {NONE}

	apply_actions: EVENT_HAND_M;
			-- An event handler to manage call-backs when apply button
			-- is activated

	cancel_actions: EVENT_HAND_M;
			-- An event handler to manage call-backs when cancel button
			-- is activated

	help_actions: EVENT_HAND_M;
			-- An event handler to manage call-backs when help button
			-- is activated

feature 

	hide_apply_button is
			-- Make apply button invisible.
		do
			xt_unmanage_child (xm_selection_box_get_child (screen_object, MDIALOG_APPLY_BUTTON))
		end;

	hide_cancel_button is
			-- Make cancel button invisible.
		do
			xt_unmanage_child (xm_selection_box_get_child (screen_object, MDIALOG_CANCEL_BUTTON))
		end;

	hide_help_button is
			-- Make help button invisible.
		do
			xt_unmanage_child (xm_selection_box_get_child (screen_object, MDIALOG_HELP_BUTTON))
		end;

	hide_ok_button is
			-- Make ok button invisible.
		do
			xt_unmanage_child (xm_selection_box_get_child (screen_object, MDIALOG_OK_BUTTON))
		end;

feature {NONE}

	ok_actions: EVENT_HAND_M;
			-- An event handler to manage call-backs when ok button
			-- is activated

feature 

	remove_apply_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- apply button is activated.
		require else
			not_a_command_void: not (a_command = Void)
		do
			apply_actions.remove (a_command, argument)
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

	selection_text: STRING is
			-- Current text in selection box
		local
			ext_name: ANY
		do
			ext_name := MtextString.to_c;
			Result := from_xm_string (screen_object, $ext_name)
		end;

	set_apply_label (a_label: STRING) is
			-- Set `a_label' as label for apply button,
			-- by default this label is `apply'.
		require else
			not_label_void: not (a_label = Void)
		local
			ext_name, ext_name_label: ANY
		do
			ext_name := MapplyLabelString.to_c;
			ext_name_label := a_label.to_c;
			to_left_xm_string (screen_object, $ext_name_label,
							$ext_name)
		end;

	set_cancel_label (a_label: STRING) is
			-- Set `a_label' as label for cancel button,
			-- by default this label is `cancel'.
		require else
			not_label_void: not (a_label = Void)
		local
			ext_name, ext_name_label: ANY
		do
			ext_name := McancelLabelString.to_c;
			ext_name_label := a_label.to_c;
			to_left_xm_string (screen_object, $ext_name_label,
							$ext_name)
		end;

	set_help_label (a_label: STRING) is
			-- Set `a_label' as label for help button,
			-- by default this label is `help'.
		require else
			not_label_void: not (a_label = Void)
		local
			ext_name, ext_name_label: ANY
		do
			ext_name_label := a_label.to_c;
			ext_name := MhelpLabelString.to_c;
			to_left_xm_string (screen_object, $ext_name_label,
							$ext_name)
		end;

	set_ok_label (a_label: STRING) is
			-- Set `a_label' as label for ok button,
			-- by default this label is `ok'.
		require else
			not_label_void: not (a_label = Void)
		local	
			ext_name, ext_name_label: ANY
		do
			ext_name_label := a_label.to_c;
			ext_name := MokLabelString.to_c;
			to_left_xm_string (screen_object, $ext_name_label,
							$ext_name)
		end;

	set_selection_label (a_label: STRING) is
			-- Set `a_label' as selection label,
			-- by default this label is `selection'.
		local
			ext_name, ext_name_label: ANY
		do
			ext_name_label := a_label.to_c;
			ext_name := MselectionLabelString.to_c;
			to_left_xm_string (screen_object, $ext_name_label,
							$ext_name)
		end;

	set_selection_text (a_text: STRING) is
			-- Set selection text to `a_text'.
		require else
			a_text_not_void: not (a_text = Void)
		local
			ext_name_text, ext_name: ANY
		do
			ext_name_text := a_text.to_c;
			ext_name := MtextString.to_c;
			to_left_xm_string (screen_object, $ext_name_text,
							$ext_name)
		end;

	show_apply_button is
			-- Make apply button visible.
		do
			xt_manage_child (xm_selection_box_get_child (screen_object, MDIALOG_APPLY_BUTTON))
		end;

	show_cancel_button is
			-- Make cancel button visible.
		do
			xt_manage_child (xm_selection_box_get_child (screen_object, MDIALOG_CANCEL_BUTTON))
		end;

	show_help_button is
			-- Make help button visible.
		do
			xt_manage_child (xm_selection_box_get_child (screen_object, MDIALOG_HELP_BUTTON))
		end;

	show_ok_button is
			-- Make ok button visible.
		do
			xt_manage_child (xm_selection_box_get_child (screen_object, MDIALOG_OK_BUTTON))
		end;

feature {NONE} -- External features

	to_left_xm_string (scr_obj: POINTER; name1, name2: ANY) is
		external
			"C"
		end;

	from_xm_string (scr_obj: POINTER; s_name: ANY): STRING is
		external
			"C"
		end;

	xm_selection_box_get_child (scr_obj: POINTER; value: INTEGER): POINTER is
		external
			"C"
		end;

	create_prompt (p_name: ANY; scr_obj: POINTER): POINTER is
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
