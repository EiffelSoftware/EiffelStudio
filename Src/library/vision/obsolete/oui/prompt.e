--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

	date: "$Date$";
	revision: "$Revision$"

class PROMPT 

inherit

	TERMINAL
		rename
			make as terminal_make
		redefine
			implementation
		end


creation

	make

	
feature 

	add_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- cancel button is activated.
		require
			not_a_command_void: not (a_command = Void)
		do
			implementation.add_cancel_action (a_command, argument)
		end; -- add_cancel_action

	add_apply_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- apply button is activated.
		require
			not_a_command_void: not (a_command = Void)
		do
			implementation.add_apply_action (a_command, argument)
		end; -- add_apply_action

	add_help_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- help button is activated.
		require
			not_a_command_void: not (a_command = Void)
		do
			implementation.add_help_action (a_command, argument)
		end; -- add_help_action

	add_ok_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- ok button is activated.
		require
			not_a_command_void: not (a_command = Void)
		do
			implementation.add_ok_action (a_command, argument)
		end; -- add_ok_action

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a prompt with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			name_not_void: not (a_name = Void);
			parent_not_void: not (a_parent = Void)
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier:= a_name.duplicate;
			implementation:= toolkit.prompt (Current);
			set_default
		ensure
			parent = a_parent;
			identifier.is_equal (a_name)
		end;

	hide_apply_button is
			-- Make apply button invisible.
		do
			implementation.hide_apply_button
		end; -- hide_apply_button

	hide_cancel_button is
			-- Make cancel button invisible.
		do
			implementation.hide_cancel_button
		end; -- hide_cancel_button

	hide_help_button is
			-- Make help button invisible.
		do
			implementation.hide_help_button
		end; -- hide_help_button

	hide_ok_button is
			-- Make ok button invisible.
		do
			implementation.hide_ok_button
		end; -- hide_ok_button

	
feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: PROMPT_I;
			-- Implementation of current prompt

	
feature 

	remove_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- cancel button is activated.
		require
			not_a_command_void: not (a_command = Void)
		do
			implementation.remove_cancel_action (a_command, argument)
		end; -- remove_cancel_action

	remove_apply_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- apply button is activated.
		require
			not_a_command_void: not (a_command = Void)
		do
			implementation.remove_apply_action (a_command, argument)
		end; -- remove_apply_action

	remove_help_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- help button is activated.
		require
			not_a_command_void: not (a_command = Void)
		do
			implementation.remove_help_action (a_command, argument)
		end; -- remove_help_action

	remove_ok_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- ok button is activated.
		require
			not_a_command_void: not (a_command = Void)
		do
			implementation.remove_ok_action (a_command, argument)
		end; -- remove_ok_action

	selection_text: STRING is
			-- Current text in selection box
		do
			Result := implementation.selection_text
		end; -- selection_text

	set_apply_label (a_label: STRING) is
			-- Set `a_label' as label for apply button,
			-- by default this label is `apply'.
		require
			not_label_void: not (a_label = Void)
		do
			implementation.set_apply_label (a_label)
		end; -- set_apply_label

	set_cancel_label (a_label: STRING) is
			-- Set `a_label' as label for cancel button,
			-- by default this label is `cancel'.
		require
			not_label_void: not (a_label = Void)
		do
			implementation.set_cancel_label (a_label)
		end; -- set_cancel_label

	set_help_label (a_label: STRING) is
			-- Set `a_label' as label for help button,
			-- by default this label is `help'.
		require
			not_label_void: not (a_label = Void)
		do
			implementation.set_help_label (a_label)
		end; -- set_help_label

	set_ok_label (a_label: STRING) is
			-- Set `a_label' as label for ok button,
			-- by default this label is `ok'.
		require
			not_label_void: not (a_label = Void)
		do
			implementation.set_ok_label (a_label)
		end; -- set_ok_label

	set_selection_label (a_label: STRING) is
			-- Set `a_label' as selection label,
			-- by default this label is `selection'.
		do
			implementation.set_selection_label (a_label)
		end; -- set_selection_label

	set_selection_text (a_text: STRING) is
			-- Set selection text to `a_text'.
		require
			a_text_not_void: not (a_text = Void)
		do
			implementation.set_selection_text (a_text)
		end; -- set_selection_text

	show_apply_button is
			-- Make apply button visible.
		do
			implementation.show_apply_button
		end; -- show_apply_button

	show_cancel_button is
			-- Make cancel button visible.
		do
			implementation.show_cancel_button
		end; -- show_cancel_button

	show_help_button is
			-- Make help button visible.
		do
			implementation.show_help_button
		end; -- show_help_button

	show_ok_button is
			-- Make ok button visible.
		do
			implementation.show_ok_button
		end -- show_ok_button

end 
