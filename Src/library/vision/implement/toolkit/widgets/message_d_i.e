indexing

	description: "General message dialog implementation";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class
		MESSAGE_D_I 

inherit

	TERMINAL_I

feature -- Status setting

	set_left_alignment is
			-- Set message alignment to beginning.
		deferred
		end;

	set_center_alignment is
			-- Set message alignment to center.
		deferred
		end;

	set_right_alignment is
			-- Set message alignment to right.
		deferred
		end;

	show_cancel_button is
			-- Make cancel button visible.
		deferred
		end;

	show_help_button is
			-- Make help button visible.
		deferred
		end;

	show_ok_button is
			-- Make ok button visible.
		deferred
		end

	hide_cancel_button is
			-- Make cancel button invisible.
		deferred
		end;

	hide_help_button is
			-- Make help button invisible.
		deferred
		end;
		
	hide_ok_button is
			-- Make ok button invisible.
		deferred
		end;

feature -- Element change

	set_help_label (a_label: STRING) is
			-- Set `a_label' as label for help button,
			-- by default this label is `help'.
		require
			not_label_void: a_label /= Void
		deferred
		end;

	set_message (a_message: STRING) is
			-- Set `a_message' as message.
		require
			not_message_void: a_message /= Void
		deferred
		end;

	set_ok_label (a_label: STRING) is
			-- Set `a_label' as label for ok button,
			-- by default this label is `ok'.
		require
			not_label_void: a_label /= Void
		deferred
		end;

	set_cancel_label (a_label: STRING) is
			-- Set `a_label' as label for cancel button,
			-- by default this label is `cancel'.
		require
			not_label_void: a_label /= Void
		deferred
		end;

	add_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- cancel button is activated.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	add_help_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- help button is activated.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	add_ok_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- ok button is activated.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

feature -- Removal

	remove_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- cancel button is activated.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;
	
	remove_help_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- help button is activated.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	remove_ok_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- ok button is activated.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

feature -- Display update

    update_display is
			-- Updates the display of all the windows in the application	
			-- Windows implementation does not do anything
        deferred
        end

end -- class MESSAGE_D_I

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

