indexing

	description: 
		"Implementation of a callback with its argument"
	legal: "See notice at end of class.";
    status: "See notice at end of class.";
    date: "$Date$";
    revision: "$Revision$"

class
	MEL_COMMAND_EXEC 

create
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class MEL_COMMAND_EXEC


