indexing
	description: "A command which executes a list of commands."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_COMMAND_LIST

inherit
	WEL_COMMAND
		undefine
			copy, is_equal
		end

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

	remove_command (command: WEL_COMMAND; argument: ANY) is
			-- Remove all `command' with `argument' from the list of commands.
		require
			command_not_void: command /= Void
		do
			from
				start
			until
				after
			loop
				if item.command = command and then
					equal (item.argument, argument) then
					remove
				else
					forth
				end
			end
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

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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

