
indexing

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class PROMPT_I 

inherit

	TERMINAL_I

feature 

	add_apply_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- apply button is activated.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- add_apply_action

	add_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- cancel button is activated.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- add_cancel_action

	add_help_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- help button is activated.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- add_help_action

	add_ok_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- ok button is activated.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- add_ok_action

	hide_apply_button is
			-- Make apply button invisible.
		deferred
		end; -- hide_apply_button

	hide_cancel_button is
			-- Make cancel button invisible.
		deferred
		end; -- hide_cancel_button

	hide_help_button is
			-- Make help button invisible.
		deferred
		end; -- hide_help_button

	hide_ok_button is
			-- Make ok button invisible.
		deferred
		end; -- hide_ok_button

	remove_apply_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- apply button is activated.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- remove_apply_action

	remove_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- cancel button is activated.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- remove_cancel_action

	remove_help_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- help button is activated.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- remove_help_action

	remove_ok_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- ok button is activated.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- remove_ok_action

	selection_text: STRING is
			-- Current text in selection box
		deferred
		end; -- selection_text

	set_apply_label (a_label: STRING) is
			-- Set `a_label' as label for apply button,
			-- by default this label is `apply'.
		require
			not_label_void: not (a_label = Void)
		deferred
		end; -- set_apply_label

	set_cancel_label (a_label: STRING) is
			-- Set `a_label' as label for cancel button,
			-- by default this label is `cancel'.
		require
			not_label_void: not (a_label = Void)
		deferred
		end; -- set_cancel_label

	set_help_label (a_label: STRING) is
			-- Set `a_label' as label for help button,
			-- by default this label is `help'.
		require
			not_label_void: not (a_label = Void)
		deferred
		end; -- set_help_label

	set_ok_label (a_label: STRING) is
			-- Set `a_label' as label for ok button,
			-- by default this label is `ok'.
		require
			not_label_void: not (a_label = Void)
		deferred
		end; -- set_ok_label

	set_selection_label (a_label: STRING) is
			-- Set `a_label' as selection label,
			-- by default this label is `selection'.
		deferred
		end; -- set_selection_label

	set_selection_text (a_text: STRING) is
			-- Set selection text to `a_text'.
		require
			a_text_not_void: not (a_text = Void)
		deferred
		end; -- set_selection_text

	show_apply_button is
			-- Make apply button visible.
		deferred
		end; -- show_apply_button

	show_cancel_button is
			-- Make cancel button visible.
		deferred
		end; -- show_cancel_button

	show_help_button is
			-- Make help button visible.
		deferred
		end; -- show_help_button

	show_ok_button is
			-- Make ok button visible.
		deferred
		end -- show_ok_button

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
