indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class PROMPT 

obsolete
	"This is only implemented for Motif.  Use MEL_SELECTION_BOX instead."

inherit

	TERMINAL_OUI
		redefine
			make, make_unmanaged, create_ev_widget,
			implementation
		end

creation

	make, make_unmanaged

feature {NONE} -- Creation

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a prompt with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			create_ev_widget (a_name, a_parent, True)
		end;

	make_unmanaged (a_name: STRING; a_parent: COMPOSITE) is
			-- Create an unmanaged prompt with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			create_ev_widget (a_name, a_parent, True)
		end;

	create_ev_widget (a_name: STRING; a_parent: COMPOSITE; man: BOOLEAN) is
			-- Create a prompt with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		local
			ot: OBSOLETE_TOOLKIT
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier:= clone (a_name);
			ot ?= toolkit;
			check
				obsolete_toolkit_instantiated: ot /= Void
			end;
			implementation:= ot.prompt (Current, man, a_parent);
			implementation.set_widget_default;
			set_default
		end;

feature

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

	
feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: PROMPT_I;
			-- Implementation of current prompt

	
feature 

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

	selection_text: STRING is
			-- Current text in selection box
		do
			Result := implementation.selection_text
		end;

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

end 



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

