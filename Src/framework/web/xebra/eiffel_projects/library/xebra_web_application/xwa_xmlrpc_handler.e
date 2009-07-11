note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XWA_XMLRPC_HANDLER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create request_handler
		end

feature -- Access

	request_handler: XRPC_REQUEST_HANDLER

feature -- Status report

feature -- Status setting

feature -- Basic operations

	handle (a_request: XH_REQUEST; a_response: XH_RESPONSE; a_dispatcher: XRPC_SERVER_DISPATCHER)
			-- Convertes from XH_REQUEST to xml-string and from response xml-string to XH_RESPONSE
		require
			a_request_attached: a_request /= Void
		do
			if a_request.is_post  then
				if attached a_request.headers_in ["Content-Type"] as l_content_type then
					if l_content_type.is_equal ("text/xml") then
							a_response.append (request_handler.response_string (a_request.args, a_dispatcher))
					else
						a_response.append ("invalid content-type") --todo ((create {XER_INVALID_CONTENT_TYPE}.make ("")).render_to_response)
					end
				else
					a_response.append ("invalid content-type") --todo (create {XER_INVALID_CONTENT_TYPE}.make ("")).render_to_response)
				end
			else
				a_response.append ("invalid method") --todo  ((create {XER_INVALID_REQUEST_METHOD}.make ("")).render_to_response)
			end
		end

feature {NONE} -- Implementation

invariant

end

