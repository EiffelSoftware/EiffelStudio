indexing
	description: "This class represents a MS_WINDOWS action"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
class

	ACTION_WINDOWS

create

	make

feature {NONE} -- Initialization

	make (a_command: COMMAND; a_argument: ANY) is
		require
			a_command_exists: a_command /= Void
		do
			command := a_command;
			argument := a_argument
		ensure
			command_set: command = a_command
			argument_set: argument = a_argument
		end


feature -- Access

	command: COMMAND

	argument: ANY

feature -- Basic operation

	execute is
		do
			command.execute (argument)
		end

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




end -- class ACTION_WINDOWS

