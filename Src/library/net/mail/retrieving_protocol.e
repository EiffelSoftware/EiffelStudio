indexing
	description: "Objects that handle the retrieving of data"
	author: "david"
	date: "$Date$"
	revision: "$Revision$"

deferred class RETRIEVING_PROTOCOL inherit

	EMAIL_PROTOCOL

feature -- Basic operations

	execute_transfer is 
			-- Do the transfer.
		deferred
		end

end -- class RETRIEVING_PROTOCOL
