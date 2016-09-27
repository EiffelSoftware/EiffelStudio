note
	description: "Reverse proxy example."
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION_EXECUTION

inherit
	WSF_EXECUTION

	WSF_URI_REWRITER
		rename
			uri as proxy_uri
		end

create
	make

feature -- Basic operations

	execute
 		do
 				-- NOTE: please enter the target server uri here
 				-- replace "http://localhost:8080/foobar"
			send_proxy_response ("http://localhost:8080/foobar", Current)
		end

	send_proxy_response (a_remote: READABLE_STRING_8; a_rewriter: detachable WSF_URI_REWRITER)
		local
			h: WSF_SIMPLE_REVERSE_PROXY_HANDLER
		do
			create h.make (a_remote)
			h.set_uri_rewriter (a_rewriter)
			h.set_uri_rewriter (create {WSF_AGENT_URI_REWRITER}.make (agent proxy_uri))
			h.set_timeout (30) -- 30 seconds
			h.set_connect_timeout (5_000) -- milliseconds = 5 seconds
			h.execute (request, response)
		end

feature -- Helpers

	proxy_uri (a_request: WSF_REQUEST): STRING
			-- Request uri rewriten as url.
		do
			Result := a_request.request_uri
		end

end
