note
	description: "[
		Factory to generate the appropriate request.
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XH_REQUEST_FACTORY

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
		end

feature -- Basic Operations

	get_request (a_request_message: STRING): detachable XH_REQUEST
			-- Returns the correct REQUEST according to the message
		require
			not_a_request_message_is_detached_or_empty: a_request_message /= Void and then not a_request_message.is_empty
		do
			if a_request_message[1] = {XH_GET_REQUEST}.method then
				create {XH_GET_REQUEST} Result.make_from_message (a_request_message)
			elseif a_request_message[1] = {XH_POST_REQUEST}.method then
				create {XH_POST_REQUEST} Result.make_from_message (a_request_message)
			end
		end
end
