indexing
	description: "A command which executes a list of commands."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_COMMAND_LIST

inherit
	WEL_COMMAND

	LINKED_LIST [WEL_COMMAND_EXEC]

creation
	make

feature -- Element change

	add_command (command: WEL_COMMAND; argument: ANY) is
			-- Add `command' with `argument' to list of commands.
		local
			exec: WEL_COMMAND_EXEC
		do
			!! exec.make (command, argument)
			extend (exec)
		end

feature -- Execution

	execute (argument: ANY) is
			-- Execute list of commands
		do
			from
				start
			until
				after
			loop
				item.command.set_message_information (message_information)
				item.command.execute (item.argument)
				forth
			end
		end
 
end -- class WEL_COMMAND_LIST

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
