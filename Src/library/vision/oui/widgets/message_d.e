indexing

	description:
		"Message box built on a dialog shell, which can %
		%be popped up or popped down at any time";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	MESSAGE_D 

inherit
	TERMINAL_OUI
		rename
			make as terminal_make
		undefine
			raise, lower
		redefine
			implementation
		end;

	DIALOG
		rename
			implementation as dialog_imp
		end

creation

	make
	
feature {NONE} -- Initialization

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a message dialog with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			valid_parent: a_name /= Void;
			parent_not_void: a_parent /= Void
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier:= clone (a_name);
			!MESSAGE_D_IMP!implementation.make (Current, a_parent);
			set_default
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name)
		end;
	

feature -- Status setting

	hide_cancel_button is
			-- Make cancel button invisible.
		require
			exists: not destroyed;
		do
			implementation.hide_cancel_button
		end;

	hide_help_button is
			-- Make help button invisible.
		require
			exists: not destroyed;
		do
			implementation.hide_help_button
		end;

	hide_ok_button is
			-- Make ok button invisible.
		require
			exists: not destroyed;
		do
			implementation.hide_ok_button
		end;
	
	set_center_alignment is
			-- Set message alignment to center.
		require
			exists: not destroyed
		do
			implementation.set_center_alignment
		end;

	set_right_alignment is
			-- Set message alignment to right.
		require
			exists: not destroyed
		do
			implementation.set_right_alignment
		end;

	set_left_alignment is
			-- Set message alignment to beginning.
		require
			exists: not destroyed;
		do
			implementation.set_left_alignment
		end;

	show_cancel_button is
			-- Make cancel button visible.
		require
			exists: not destroyed;
		do
			implementation.show_cancel_button
		end;

	show_help_button is
			-- Make help button visible.
		require
			exists: not destroyed;
		do
			implementation.show_help_button
		end;

	show_ok_button is
			-- Make ok button visible.
		require
			exists: not destroyed;
		do
			implementation.show_ok_button
		end

feature -- Element change

	set_cancel_label (a_label: STRING) is
			-- Set `a_label' as label for cancel button,
			-- by default this label is `cancel'.
		require
			exists: not destroyed;
			not_label_void: a_label /= Void
		do
			implementation.set_cancel_label (a_label)
		end;

	set_help_label (a_label: STRING) is
			-- Set `a_label' as label for help button,
			-- by default this label is `help'.
		require
			exists: not destroyed;
			not_label_void: a_label /= Void
		do
			implementation.set_help_label (a_label)
		end;

	set_message (a_message: STRING) is
			-- Set `a_message' as message.
		require
			exists: not destroyed;
			not_message_void: a_message /= Void
		do
			implementation.set_message (a_message)
		end;

	set_ok_label (a_label: STRING) is
			-- Set `a_label' as label for ok button,
			-- by default this label is `ok'.
		require
			exists: not destroyed;
			not_label_void: a_label /= Void
		do
			implementation.set_ok_label (a_label)
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

feature -- Display update

    update_display is
            -- Updates the display of all the windows in the application    
            -- Windows implementation does not anything
        do
            implementation.update_display
        end

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT} -- Implementation

	implementation: MESSAGE_D_I
			-- Implementation of message dialog


end -- class MESSAGE_D



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

