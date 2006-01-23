indexing
	description: "General notion of command. To write an actual command %
		%inherit from this class and implement the `execute' feature."
	legal: "See notice at end of class."
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




end -- class WEL_COMMAND

