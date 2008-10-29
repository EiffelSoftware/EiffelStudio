indexing
	description: "Summary description for {ITP_REQUEST_CONSTANTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ITP_SHARED_CONSTANTS

feature -- Access

	start_request_flag: NATURAL_8 is 1
			-- Flag for "start" request

	quit_request_flag: NATURAL_8 is 2
			-- Flag for "quit" request

	execute_request_flag: NATURAL_8 is 3
			-- Flag for "execute" request

	type_request_flag: NATURAL_8 is 4
			-- Flag for "type" request

	response_starter_flag: NATURAL_8 is 1
			-- Flag to indicate that raw response is followed.
			-- Used in socket IPC.

end
