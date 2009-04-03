note
	description: "[
		Factory to generate the appropriate request
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XU_REQUEST_FACTORY

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
		end

feature -- Basic Operations

	get_request (l_request_message: STRING): detachable XH_REQUEST
			-- Returns the correct REQUEST according to the message
		do
			if l_request_message[1] = {XH_GET_REQUEST}.method then
				create {XH_GET_REQUEST} Result.make_from_message (l_request_message)
			elseif l_request_message[1] = {XH_POST_REQUEST}.method then
				create {XH_POST_REQUEST} Result.make_from_message (l_request_message)
			end
		end
end
