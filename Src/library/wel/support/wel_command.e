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


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

