indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class COMMAND_EXEC 

inherit

	EVENT_HDL
		export
			{NONE} all
		redefine
			is_equal
		end

creation

	make

feature 

	argument: ANY;
			-- Argument to be given to `command' before execution

	command: COMMAND;
			-- Command to execute

	make (a_command: COMMAND; an_argument: ANY) is
			-- Store `a_command' and `an_argument'.
		do
			command := a_command;
			argument := an_argument
		end; 

	execute (context_data: CONTEXT_DATA) is
			-- Execute `command' with `argument' and `context_data'.
		local
			command_clone: COMMAND
		do
			if command.is_template then
				command_clone := clone (command)
			else
				command_clone := command
			end;
			command_clone.set_context_data (context_data);
			command_clone.execute (argument)
		end;

	is_equal (other: like Current): BOOLEAN is
			-- Is Current equal to `other' ?
		do
			Result := command = other.command and then
				equal (argument, other.argument)
		end;

invariant

	valid_command: command /= Void

end 


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
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
