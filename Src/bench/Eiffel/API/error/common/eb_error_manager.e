indexing
	description	: "Objects that helps managing the errors"
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_ERROR_MANAGER

feature -- Access

	error_messages: LINKED_LIST [STRING] is
			-- Current error messages.
		once
			create Result.make
		end

feature -- Element change

	add_error_message, set_error_message (an_error_message: STRING) is
			-- Add `an_error_message' to the list of error messages.
		do
			error_messages.extend (an_error_message)
		end

feature -- Removal

	clear_error_messages is
			-- Clear the list of error messages
		do
			error_messages.wipe_out
		end

end -- class EB_ERROR_MANAGER
