note
	description: "Summary description for {WSF_DEFAULT_RESPONSE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_DEFAULT_RESPONSE

inherit
	WSF_RESPONSE_MESSAGE

create
	make

feature {NONE} -- Initialization

	make (req: WSF_REQUEST)
			-- Initialize Current with request `req'
		do
			request := req
		end

feature -- Access

	request: WSF_REQUEST
			-- Associated request.

feature {WSF_RESPONSE} -- Output

	send_to (res: WSF_RESPONSE)
			-- Send Current message to `res'
			--
			-- This feature should be called via `{WSF_RESPONSE}.send (obj)'
			-- where `obj' is the current object
		local
			msg: WSF_RESPONSE_MESSAGE
			req: like request
		do
			req := request
			if req.is_request_method ({HTTP_REQUEST_METHODS}.method_trace) then
				msg := trace_message (req)
			else
				msg := not_found_message (req)
			end
			res.send (msg)
		end

feature {NONE} -- Implementation

	trace_message (req: WSF_REQUEST): WSF_TRACE_RESPONSE
		do
			create Result.make (req)
		end

	not_found_message (req: WSF_REQUEST): WSF_NOT_FOUND_RESPONSE
		do
			create Result.make (req)
		end

end
