--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                      (805) 685-1006                                --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

	date: "$Date$";
	revision: "$Revision$"

class COMMAND_EXEC 

inherit

	EVENT_HDL
		export
			{NONE} all
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
		end 

invariant

	not (command = Void)

end 
