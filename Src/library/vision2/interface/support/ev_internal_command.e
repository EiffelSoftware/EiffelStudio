indexing
	description:
		" EiffelVision internal command. Structure that keep%
		% a command and the argument that comes with it."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_INTERNAL_COMMAND

creation
	make

feature -- Initialization

	make (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Create the object with `cmd' and `arg' as
			-- arguments.
		do
			command := cmd
			argument := arg
		end

feature -- Access

	command: EV_COMMAND
			-- Command of the current object

	argument: EV_ARGUMENT
			-- Argument of the current object

feature -- Basic operations

	execute (data: EV_EVENT_DATA) is
			-- Execute `command' with `argument' and `data'.
		do
			command.execute (argument, data)
		end

end -- class EV_INTERNAL_COMMAND

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
