indexing
	description: "Execute commands."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_COMMAND_EXEC

create
	make

feature -- Initialization

	make (a_command: WEL_COMMAND; an_argument: ANY) is
			-- Set `command' and `argument' with 
			-- `a_command' and `an_argument'.
		require
			a_command_not_void: a_command /= Void
		do
			command := a_command
			argument := an_argument
		ensure
			command_set: command = a_command
			argument_set: argument = an_argument
		end

feature -- Access

	command: WEL_COMMAND
			-- User-defined command to execute

	argument: ANY
			-- Argument to be given to `command' before execution

feature -- Execution

	execute (window: WEL_WINDOW; message: INTEGER; wparam, lparam: POINTER) is
			-- Create message information corresponding to `message'
			-- and execute `command'.
		require
			window_not_void: window /= Void
			positive_message: message >= 0
		local
			creator: WEL_MESSAGE_INFORMATION_CREATOR
		do
			create creator.make (window, message, wparam, lparam)
			command.set_message_information (creator.message_information)
			command.execute (argument)
		end

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




end -- class WEL_COMMAND_EXEC

