indexing

	description: "General toggle button implementation";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class TOGGLE_B_I 

inherit

	BUTTON_I
	
feature 

	add_value_changed_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when value
			-- is changed.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- add_value_changed_action

	arm is
			-- Assign True to `state'.
		deferred
		ensure
			state_is_true: state
		end; -- arm

	disarm is
			-- Assign False to `state'
		deferred
		ensure
			state_is_false: not state
		end; -- disarm

	remove_value_changed_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- value is changed.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- remove_value_changed_action

	state: BOOLEAN is
			-- State of current toggle button.
		deferred
		end -- state

	set_toggle_on is
			-- Set Current toggle on and set
			-- state to True.
		deferred
		ensure
			state_is_true: state
		end;

	set_toggle_off is
			-- Set Current toggle off and set
			-- state to False.
		deferred
		ensure
			state_is_false: not state
		end;

feature

	add_activate_action (a_command: COMMAND; argument: ANY) is
		deferred
		end;

	remove_activate_action (a_command: COMMAND; argument: ANY) is
		deferred
		end;

end --class TOGGLE_B_I


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
