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

create
	make

feature -- Element change

	add_command (command: WEL_COMMAND; argument: ANY) is
			-- Add `command' with `argument' to list of commands.
		local
			exec: WEL_COMMAND_EXEC
		do
			create exec.make (command, argument)
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
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

