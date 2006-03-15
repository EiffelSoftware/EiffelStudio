indexing

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	COMMAND_EXEC

inherit

	EVENT_HDL
		export
			{NONE} all
		redefine
			is_equal
		end

create

	make

feature -- Initialization

	make (a_command: COMMAND; an_argument: ANY) is
			-- Store `a_command' and `an_argument'.
		do
			command := a_command;
			argument := an_argument
		end;

feature -- Access

	argument: ANY;
			-- Argument to be given to `command' before execution

	command: COMMAND;
			-- Command to execute

feature -- Basic operations

	execute (context_data: CONTEXT_DATA) is
			-- Execute `command' with `argument' and `context_data'.
		local
			command_clone: COMMAND
		do
			if command.is_template then
				command_clone := command.twin
			else
				command_clone := command
			end;
			command_clone.set_context_data (context_data);
			command_clone.execute (argument)
		end;

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is Current equal to `other' ?
		do
			Result := command = other.command and then
				equal (argument, other.argument)
		end;

invariant

	valid_command: command /= Void

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




end -- class COMMAND_EXEC

