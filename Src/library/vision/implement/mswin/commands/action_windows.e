indexing
	description: "This class represents a MS_WINDOWS action"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
class

	ACTION_WINDOWS

creation

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

end -- class ACTION_WINDOWS

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
