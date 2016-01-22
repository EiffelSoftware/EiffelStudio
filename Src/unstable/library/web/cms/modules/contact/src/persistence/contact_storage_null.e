note
	description: "[
			Objects that ...
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	CONTACT_STORAGE_NULL

inherit
	CONTACT_STORAGE_I

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			create error_handler.make
		end

feature -- Error Handling

	error_handler: ERROR_HANDLER
			-- Error handler.	

feature -- Access

feature -- Change

	save_contact_message (m: CONTACT_MESSAGE)
		do
		end

end
