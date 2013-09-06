note
	description: "Work in progress Common abstraction to handle RESTfull methods."
	author: "Olivier Ligot"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_RESOURCE_CONTEXT_HANDLER_HELPER [C -> WSF_HANDLER_CONTEXT create make end]

feature -- Basic operations

	execute_methods (ctx: C; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request and dispatch according to the request method
		local
			m: READABLE_STRING_8
		do
			m := req.request_method.as_upper
			if     m.same_string ({HTTP_REQUEST_METHODS}.method_get) then
				execute_get (ctx, req, res)
			elseif m.same_string ({HTTP_REQUEST_METHODS}.method_put) then
				execute_put (ctx, req, res)
			elseif m.same_string ({HTTP_REQUEST_METHODS}.method_delete) then
				execute_delete (ctx, req, res)
			elseif m.same_string ({HTTP_REQUEST_METHODS}.method_post) then
				execute_post (ctx, req, res)
			elseif m.same_string ({HTTP_REQUEST_METHODS}.method_trace) then
				execute_trace (ctx, req, res)
			elseif m.same_string ({HTTP_REQUEST_METHODS}.method_options) then
				execute_options (ctx, req, res)
			elseif m.same_string ({HTTP_REQUEST_METHODS}.method_head) then
				execute_head (ctx, req, res)
			elseif m.same_string ({HTTP_REQUEST_METHODS}.method_connect) then
				execute_connect (ctx, req, res)
			else
					--| Eventually handle other methods...
				execute_extension_method (ctx, req, res)
			end
		end

feature -- Method Get

	execute_get (ctx: C; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			do_get (ctx, req, res)
		end

	do_get (ctx: C; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Using GET to retrieve resource information.
			-- If the GET request is SUCCESS, we response with
			-- 200 OK, and a representation of the person
			-- If the GET request is not SUCCESS, we response with
			-- 404 Resource not found
			-- If is a Condition GET and the resource does not change we send a
			-- 304, Resource not modifed
		do
			handle_not_implemented ("Method GET not implemented", req, res)
		end

feature -- Method Post

	execute_post (ctx: C; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			if req.is_chunked_input then
				do_post (ctx, req, res)
			else
				if req.content_length_value > 0 then
					do_post (ctx, req, res)
				else
					handle_bad_request_response ("Bad request, content_length empty", req, res)
				end
			end
		end

	do_post (ctx: C; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Here the convention is the following.
			-- POST is used for creation and the server determines the URI
			-- of the created resource.
			-- If the request post is SUCCESS, the server will create the order and will response with
			-- HTTP_RESPONSE 201 CREATED, the Location header will contains the newly created order's URI
			-- if the request post is not SUCCESS, the server will response with
			-- HTTP_RESPONSE 400 BAD REQUEST, the client send a bad request
			-- HTTP_RESPONSE 500 INTERNAL_SERVER_ERROR, when the server can deliver the request
		do
			handle_not_implemented ("Method POST not implemented",  req, res)
		end

feature-- Method Put		

	execute_put (ctx: C; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			if req.is_chunked_input then
				do_put (ctx, req, res)
			else
				if req.content_length_value > 0 then
					do_put (ctx, req, res)
				else
					handle_bad_request_response ("Bad request, content_length empty", req, res)
				end
			end
		end

	do_put (ctx: C; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			handle_not_implemented ("Method PUT not implemented", req, res)
		end

feature -- Method DELETE		

	execute_delete (ctx: C; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			do_delete (ctx, req, res)
		end

	do_delete (ctx: C; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Here we use DELETE to logically delete a person.
			-- 204 if is ok
			-- 404 Resource not found
			-- 500 if we have an internal server error
		do
			handle_not_implemented ("Method DELETE not implemented", req, res)
		end

feature -- Method CONNECT

	execute_connect (ctx: C; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			do_connect (ctx, req, res)
		end

	do_connect (ctx: C; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			handle_not_implemented ("Method CONNECT not implemented", req, res)
		end

feature -- Method HEAD		

	execute_head (ctx: C; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			do_head (ctx, req, res)
		end

	do_head (ctx: C; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Using HEAD to retrieve resource information.
			-- If the HEAD request is SUCCESS, we response with
			-- 200 OK, and WITHOUT a representation of the person
			-- If the HEAD request is not SUCCESS, we response with
			-- 404 Resource not found
			-- If is a Condition HEAD and the resource does not change we send a
			-- 304, Resource not modifed
		do
			handle_not_implemented ("Method HEAD not implemented", req, res)
		end

feature -- Method OPTIONS

	execute_options (ctx: C; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			do_options (ctx, req, res)
		end

	do_options (ctx: C; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Using OPTIONS to retrieve resource information.
			-- If the OPTIONS request is SUCCESS, we response with 200 OK
		do
			handle_not_implemented ("Method OPTIONS not implemented", req, res)
		end

feature -- Method TRACE

	execute_trace (ctx: C; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			do_trace (ctx, req, res)
		end

	do_trace (ctx: C; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			handle_not_implemented ("Method TRACE not implemented", req, res)
		end

feature -- Method Extension Method		

	execute_extension_method (ctx: C; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			do_extension_method (ctx, req, res)
		end

	do_extension_method (ctx: C; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			handle_not_implemented ("Method extension-method not implemented", req, res)
		end

feature -- Handle responses
	-- TODO Handle Content negotiation.
	-- The option : Server-driven negotiation: uses request headers to select a variant
	-- More info : http://www.w3.org/Protocols/rfc2616/rfc2616-sec12.html#sec12

--	supported_content_types: detachable ARRAY [READABLE_STRING_8]
--			-- Supported content types
--			-- Can be redefined
--		do
--			Result := Void
--		end

	handle_error (a_description: STRING; a_status_code: INTEGER; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Handle an error.
		local
			h: HTTP_HEADER
		do
			create h.make
			h.put_content_type_text_plain
			h.put_content_length (a_description.count)
			h.put_current_date
			res.set_status_code (a_status_code)
			res.put_header_text (h.string)
			res.put_string (a_description)
		end

	handle_not_implemented (a_description: STRING; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			handle_error (a_description, {HTTP_STATUS_CODE}.not_implemented, req, res)
		end

	handle_bad_request_response (a_description: STRING; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			handle_error (a_description, {HTTP_STATUS_CODE}.bad_request, req, res)
		end

	handle_resource_not_found_response (a_description: STRING; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			handle_error (a_description, {HTTP_STATUS_CODE}.not_found, req, res)
		end

	handle_forbidden (a_description: STRING; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Handle forbidden.
		do
			handle_error (a_description, {HTTP_STATUS_CODE}.forbidden, req, res)
		end

feature -- Handle responses: others		

	handle_precondition_fail_response (a_description: STRING; req: WSF_REQUEST; res: WSF_RESPONSE )
		do
			handle_error (a_description, {HTTP_STATUS_CODE}.precondition_failed, req, res)
		end

	handle_internal_server_error (a_description: STRING; req: WSF_REQUEST; res: WSF_RESPONSE )
		do
			handle_error (a_description, {HTTP_STATUS_CODE}.internal_server_error, req, res)
		end

	handle_method_not_allowed_response (a_description: STRING; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			handle_error (a_description, {HTTP_STATUS_CODE}.method_not_allowed, req, res)
		end

	handle_resource_not_modified_response (a_description: STRING; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			handle_error (a_description, {HTTP_STATUS_CODE}.not_modified, req, res)
		end

	handle_resource_conflict_response (a_description: STRING; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			handle_error (a_description, {HTTP_STATUS_CODE}.conflict, req, res)
		end

note
	copyright: "2011-2012, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
