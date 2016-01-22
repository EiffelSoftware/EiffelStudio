note
	description: "[
			Persistence interface for CONTACT_MODULE.
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONTACT_STORAGE_I

feature -- Error Handling

	error_handler: ERROR_HANDLER
			-- Error handler.
		deferred
		end

feature -- Access

feature -- Change

	save_contact_message (m: CONTACT_MESSAGE)
		deferred
		end

end
