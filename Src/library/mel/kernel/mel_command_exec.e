indexing

	description: 
		"Implementation of a callback with its argument";
    status: "See notice at end of class.";
    date: "$Date$";
    revision: "$Revision$"

class
	MEL_COMMAND_EXEC 

creation
	make

feature {NONE} -- Initialization

	make (a_command: MEL_COMMAND; an_argument: ANY) is
			-- Store `a_command' and `an_argument'.
		do
			command := a_command;
			argument := an_argument
		end;

feature -- Access

	argument: ANY;
			-- Argument to be given to `command' before execution

	command: MEL_COMMAND;
			-- Command to execute

feature -- Basic operations

	execute (a_callback_struct: MEL_CALLBACK_STRUCT) is
			-- Execute `command' with `argument' and `a_callback_struct'.
		do
			command.set_callback_struct (a_callback_struct);
			command.execute (argument)
		end;

invariant

	command_not_void: command /= Void

end -- class MEL_COMMAND_EXEC


--|----------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel.
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

