indexing
	description: "This class represents a MS_WINDOWS action"
	status: "See notice at end of class"
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

end -- class ACTION_WINDOWS

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

