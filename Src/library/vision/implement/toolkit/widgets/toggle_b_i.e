indexing

	description: "General toggle button implementation";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	TOGGLE_B_I 

inherit

	BUTTON_I
	
feature -- Status setting

	arm is
			-- Assign True to `state'.
		deferred
		ensure
			state_is_true: state
		end;

	disarm is
			-- Assign False to `state'
		deferred
		ensure
			state_is_false: not state
		end;

	state: BOOLEAN is
			-- State of current toggle button.
		deferred
		end

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

feature -- Element change

	add_value_changed_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when value
			-- is changed.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	add_activate_action (a_command: COMMAND; argument: ANY) is
		deferred
		end;

	set_accelerator_action (a_translation: STRING) is
			-- Set the accerlator action (modifiers and key to use as a shortcut
			-- in selecting a button) to `a_translation'.
			-- `a_translation' must be specified with the X toolkit conventions.
		require
			translation_not_void: a_translation /= Void
		deferred
		end;

feature -- Removal

	remove_activate_action (a_command: COMMAND; argument: ANY) is
		deferred
		end;

	remove_accelerator_action is
			-- Remove the accelerator action.
		deferred
		end;

	remove_value_changed_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- value is changed.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

end --class TOGGLE_B_I



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

