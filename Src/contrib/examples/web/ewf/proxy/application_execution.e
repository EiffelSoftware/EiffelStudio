note
	description: "Reverse proxy example."
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION_EXECUTION

inherit
	WSF_EXECUTION

create
	make

feature -- Basic operations

	execute
		local
			l_forwarded: BOOLEAN
 		do
 				-- Hardocoded for the example
 			if request.server_name.same_string ("foo") then
 				send_proxy_response ("http://localhost:8080/foo", Void)
 				l_forwarded := True
 			elseif request.server_name.same_string ("bar") then
				send_proxy_response ("http://localhost:8080/bar", Void)
				l_forwarded := True
			elseif request.path_info.starts_with_general ("/search/") then
				 send_proxy_response ("http://www.google.com/search?q=", agent uri_for_location_based_proxy ("/search/", ?))
			else
				response.send (create {WSF_PAGE_RESPONSE}.make_with_body ("EiffelWeb proxy: not forwarded!"))
			end
		end

	send_proxy_response (a_remote: READABLE_STRING_8; a_rewriter: detachable FUNCTION [WSF_REQUEST, STRING])
		local
			h: WSF_SIMPLE_REVERSE_PROXY_HANDLER
		do
			create h.make (a_remote)
			if a_rewriter /= Void then
				h.set_uri_rewriter (create {WSF_AGENT_URI_REWRITER}.make (a_rewriter))
			end
			h.set_timeout_ns (10_000_000_000) -- 10 seconds
			h.set_connect_timeout (5_000) -- milliseconds = 5 seconds

			-- Uncomment following, if you want to provide proxy information
--			h.set_header_via (True)
--			h.set_header_forwarded (True)
--			h.set_header_x_forwarded (True)
			-- Uncomment following line to keep the original Host value.
--			h.keep_proxy_host (True)

				-- For debug information, uncomment next line
--			response.put_error ("Forwarding to " + h.proxy_url (request))

			h.execute (request, response)
		end

feature -- Helpers

	uri_for_location_based_proxy (a_location: READABLE_STRING_8; a_request: WSF_REQUEST): STRING
			-- Request uri rewritten as url.
		do
			Result := a_request.request_uri
				-- If related proxy setting is
				-- a_location=/foo -> http://foo.com
				-- and if request was http://example.com/foo/bar, it will use http://foo.com/bar
				-- so the Result here, is "/bar"
			if Result.starts_with (a_location) then
				Result.remove_head (a_location.count)
			end
		end

end
