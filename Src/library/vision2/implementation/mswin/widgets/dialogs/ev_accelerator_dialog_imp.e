indexing
	description: "EiffelVision accelerator selectio dialog, mswindows implementation."
	status: "See notice at end for class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_ACCELERATOR_DIALOG_IMP

inherit
	EV_ACCELERATOR_DIALOG_I

create
	make,
	make_with_text,
	make_with_actions,
	make_with_all	

feature -- Event - command association

	add_ok_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed when
			-- the "OK" button is pressed.
			-- If there is no "OK" button, the event never occurs.
		do
		end

	add_cancel_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed when
			-- the "Cancel" button is pressed.
			-- If there is no "Cancel" button, the event never occurs.
		do
		end

feature -- Event -- removing command association

	remove_ok_commands is
			-- Empty the list of commands to be executed when
			-- "OK" button is pressed.
		do
		end

	remove_cancel_commands is
			-- Empty the list of commands to be executed when
			-- "Cancel" button is pressed.
		do
		end

end -- class EV_ACCELERATOR_DIALOG_IMP

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
