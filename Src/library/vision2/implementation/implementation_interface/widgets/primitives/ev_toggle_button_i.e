indexing

	description: "General toggle button implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class

	EV_TOGGLE_BUTTON_I 

inherit

	EV_BUTTON_I
	
feature -- Status report
	
	state: BOOLEAN is
			-- Is toggle button pressed ?
		require
			exists: not destroyed
		deferred
		end 
	
feature -- Status setting

	set_state (flag: BOOLEAN) is
			-- Set Current toggle on and set
			-- pressed to True.
		require
			exists: not destroyed
		deferred
		ensure
			correct_state: state = flag
		end

	toggle is
			-- Change the state of the toggle button to
			-- opposite
		require
			exists: not destroyed
		deferred
		ensure
			state_is_true: state = not old state
		end

feature -- Event - command association
	
	add_toggle_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is	
			-- Add 'cmd' to the list of commands to be executed
			-- when the button is toggled.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		deferred
		end	

feature -- Event -- removing command association

	remove_toggle_commands is	
			-- Empty the list of commands to be executed
			-- when the button is toggled.
		require
			exists: not destroyed
		deferred
		end	

end -- class EV_TOGGLE_BUTTON_I


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

