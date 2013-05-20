note
	description: "[
	
			Safe method: HEAD, GET, TRACE, OPTIONS
				Intended only for information retrieval, should not change state of server

	
			See http://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol#Request_methods
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	HTTP_REQUEST_METHODS

feature -- Query

	method (m: READABLE_STRING_8): READABLE_STRING_8
			-- Return the associated constant object if any
			-- otherwise the uppercased version of `m'
		do
			if m.is_case_insensitive_equal (method_get) then
				Result := method_get
			elseif m.is_case_insensitive_equal (method_post) then
				Result := method_post
			elseif m.is_case_insensitive_equal (method_head) then
				Result := method_head
			elseif m.is_case_insensitive_equal (method_trace) then
				Result := method_trace
			elseif m.is_case_insensitive_equal (method_options) then
				Result := method_options
			elseif m.is_case_insensitive_equal (method_put) then
				Result := method_put
			elseif m.is_case_insensitive_equal (method_delete) then
				Result := method_delete
			elseif m.is_case_insensitive_equal (method_connect) then
				Result := method_connect
			elseif m.is_case_insensitive_equal (method_patch) then
				Result := method_patch
			else
				Result := m.as_upper
			end
		end

feature -- Safe Methods

	method_head: STRING = "HEAD"
			-- Asks for the response identical to the one that would correspond
			-- to a GET request, but without the response body.
			-- This is useful for retrieving meta-information written in response headers,
			-- without having to transport the entire content.

	method_get: STRING = "GET"
			-- Requests a representation of the specified resource.
			-- Requests using GET (and a few other HTTP methods)
			--  "SHOULD NOT have the significance of taking an action other than retrieval"
			-- The W3C has published guidance principles on this distinction, saying,
			-- "Web application design should be informed by the above principles,
			--  but also by the relevant limitations."

	method_trace: STRING = "TRACE"
			-- Echoes back the received request, so that a client can see what
			-- (if any) changes or additions have been made by intermediate servers.

	method_options: STRING = "OPTIONS"
			-- Returns the HTTP methods that the server supports for specified URL.
			-- This can be used to check the functionality of a web server by requesting '*'
			-- instead of a specific resource.

feature -- Methods intented for actions

	method_post: STRING = "POST"
			-- Submits data to be processed (e.g., from an HTML form) to the identified resource.
			-- The data is included in the body of the request.
			-- This may result in the creation of a new resource or the updates of existing
			-- resources or both.	

	method_put: STRING = "PUT"
			-- Uploads a representation of the specified resource.

	method_delete: STRING = "DELETE"
			-- Deletes the specified resource.

feature -- Other Methods

	method_connect: STRING = "CONNECT"
			-- Converts the request connection to a transparent TCP/IP tunnel,
			-- usually to facilitate SSL-encrypted communication (HTTPS) through
			-- an unencrypted HTTP proxy.

	method_patch: STRING = "PATCH"
			-- Is used to apply partial modifications to a resource

note
	copyright: "2011-2012, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
