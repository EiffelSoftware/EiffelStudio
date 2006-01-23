indexing

	description: "Dialog with a text field"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	PROMPT_D 

inherit

	TERMINAL_OUI
		rename
			make as terminal_make
		undefine
			raise, lower
		redefine
			implementation
		end

	DIALOG
		rename
			implementation as dialog_imp
		end

create

	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a prompt dialog with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			valid_parent: a_name /= Void;
			parent_not_void: a_parent /= Void
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier:= clone (a_name);
			create {PROMPT_D_IMP} implementation.make (Current, a_parent);
			set_default
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name)
		end;

feature -- Access

	selection_text: STRING is
			-- Current text in selection box
		do
			Result := implementation.selection_text
		end;

feature -- Status setting

	show_apply_button is
			-- Make apply button visible.
		require
			exists: not destroyed
		do
			implementation.show_apply_button
		end;

	show_cancel_button is
			-- Make cancel button visible.
		require
			exists: not destroyed
		do
			implementation.show_cancel_button
		end;

	show_help_button is
			-- Make help button visible.
		require
			exists: not destroyed
		do
			implementation.show_help_button
		end;

	show_ok_button is
			-- Make ok button visible.
		require
			exists: not destroyed
		do
			implementation.show_ok_button
		end 

	hide_apply_button is
			-- Make apply button invisible.
		do
			implementation.hide_apply_button
		end;

	hide_cancel_button is
			-- Make cancel button invisible.
		do
			implementation.hide_cancel_button
		end;

	hide_help_button is
			-- Make help button invisible.
		do
			implementation.hide_help_button
		end;

	hide_ok_button is
			-- Make ok button invisible.
		do
			implementation.hide_ok_button
		end;

feature -- Element change

	set_apply_label (a_label: STRING) is
			-- Set `a_label' as label for apply button,
			-- by default this label is `apply'.
		require
			exists: not destroyed;
			not_label_void: a_label /= Void
		do
			implementation.set_apply_label (a_label)
		end;

	set_cancel_label (a_label: STRING) is
			-- Set `a_label' as label for cancel button,
			-- by default this label is `cancel'.
		require
			exists: not destroyed;
			not_label_void: a_label /=Void
		do
			implementation.set_cancel_label (a_label)
		end;

	set_help_label (a_label: STRING) is
			-- Set `a_label' as label for help button,
			-- by default this label is `help'.
		require
			exists: not destroyed;
			not_label_void: a_label /=Void
		do
			implementation.set_help_label (a_label)
		end;

	set_ok_label (a_label: STRING) is
			-- Set `a_label' as label for ok button,
			-- by default this label is `ok'.
		require
			exists: not destroyed;
			not_label_void: a_label /=Void
		do
			implementation.set_ok_label (a_label)
		end;

	set_selection_label (a_label: STRING) is
			-- Set `a_label' as selection label,
			-- by default this label is `selection'.
		require
			exists: not destroyed
			not_label_void: a_label /=Void
		do
			implementation.set_selection_label (a_label)
		end;

	set_selection_text (a_text: STRING) is
			-- Set selection text to `a_text'.
		require
			exists: not destroyed;
			a_text_not_void: a_text /= Void
		do
			implementation.set_selection_text (a_text)
		end;

	add_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- cancel button is activated.
		require
			exists: not destroyed;
			not_a_command_void: a_command /= Void
		do
			implementation.add_cancel_action (a_command, argument)
		end;

	add_apply_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- apply button is activated.
		require
			exists: not destroyed;
			not_a_command_void: a_command /= Void
		do
			implementation.add_apply_action (a_command, argument)
		end;

	add_help_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- help button is activated.
		require
			exists: not destroyed;
			not_a_command_void: a_command /= Void
		do
			implementation.add_help_action (a_command, argument)
		end;

	add_ok_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- ok button is activated.
		require
			exists: not destroyed;
			not_a_command_void: a_command /= Void
		do
			implementation.add_ok_action (a_command, argument)
		end;

feature -- Removal

	remove_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- cancel button is activated.
		require
			exists: not destroyed;
			not_a_command_void: a_command /= Void
		do
			implementation.remove_cancel_action (a_command, argument)
		end;

	remove_apply_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- apply button is activated.
		require
			exists: not destroyed;
			not_a_command_void: a_command /= Void
		do
			implementation.remove_apply_action (a_command, argument)
		end;

	remove_help_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- help button is activated.
		require
			exists: not destroyed;
			not_a_command_void: a_command /= Void
		do
			implementation.remove_help_action (a_command, argument)
		end;

	remove_ok_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- ok button is activated.
		require
			exists: not destroyed;
			not_a_command_void: a_command /= Void
		do
			implementation.remove_ok_action (a_command, argument)
		end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT} -- Implementatino

	implementation: PROMPT_D_I;
			-- Implementation of current prompt dialog

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




end -- class PROMPT_D

