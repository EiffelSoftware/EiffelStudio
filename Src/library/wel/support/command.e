indexing
	description: "General notion of command. To write an actual command %
		%inherit from this class and implement the `execute' feature."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEL_COMMAND

feature -- Access

	message_information: WEL_MESSAGE_INFORMATION
			-- Information associated to the message

feature -- Execution

	execute (argument: ANY) is
			-- Execute the command with `argument'.
		deferred
		end

feature -- Element change

	set_message_information (mi: WEL_MESSAGE_INFORMATION) is
			-- Set `message_information' with `mi'.
		do
			message_information := mi
		ensure
			message_information_set: message_information = mi
		end

end -- class WEL_COMMAND

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
