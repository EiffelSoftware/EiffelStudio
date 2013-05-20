note
	description: "Work in progress Common abstraction to handle RESTfull methods"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class	WSF_RESOURCE_HANDLER_HELPER

inherit

	WSF_METHOD_HANDLERS

feature -- Execute template

	execute_methods (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request and dispatch according to the request method.
		require
			req_attached: req /= Void
			res_attached: res /= Void
		local
			m: READABLE_STRING_8
		do
			m := req.request_method.as_upper
			if     m.same_string ({HTTP_REQUEST_METHODS}.method_get) then
				execute_get (req, res)
			elseif m.same_string ({HTTP_REQUEST_METHODS}.method_put) then
				execute_put (req, res)
			elseif m.same_string ({HTTP_REQUEST_METHODS}.method_delete) then
				execute_delete (req, res)
			elseif m.same_string ({HTTP_REQUEST_METHODS}.method_post) then
				execute_post (req, res)
			elseif m.same_string ({HTTP_REQUEST_METHODS}.method_trace) then
				execute_trace (req, res)
			elseif m.same_string ({HTTP_REQUEST_METHODS}.method_options) then
				execute_options (req, res)
			elseif m.same_string ({HTTP_REQUEST_METHODS}.method_head) then
				execute_head (req, res)
			elseif m.same_string ({HTTP_REQUEST_METHODS}.method_connect) then
				execute_connect (req, res)
			else
					--| Eventually handle other methods...
				execute_extension_method (req, res)
			end
		end

feature -- Method Get

	execute_get (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute `req' responding into `res'.
		require
			req_attached: req /= Void
			res_attached: res /= Void
			get_method: req.is_request_method ({HTTP_REQUEST_METHODS}.method_get)
		do
			do_get (req, res)
		end

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Using GET to retrieve resource information.
			-- If the GET request is SUCCESS, we respond with
			-- 200 OK, and a representation of the resource.
			-- If the GET request is not SUCCESS, we response with
			-- 404 Resource not found.
			-- If is a Condition GET and the resource does not change we send a
			-- 304, Resource not modifed.
		do
			handle_not_implemented ("Method GET not implemented", req, res)
		end

feature -- Method Post

	execute_post (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute `req' responding into `res'.
		require
			req_attached: req /= Void
			res_attached: res /= Void
			post_method: req.is_request_method ({HTTP_REQUEST_METHODS}.method_post)
		do
			if req.is_chunked_input then
				do_post (req, res)
			else
				if req.content_length_value > 0 then
					do_post (req, res)
				else
					handle_bad_request_response ("Bad request, content_length empty", req, res)
				end
			end
		end

	do_post (req: WSF_REQUEST; res: WSF_RESPONSE)
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

	execute_put (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute `req' responding into `res'.
		require
			req_attached: req /= Void
			res_attached: res /= Void
			put_method: req.is_request_method ({HTTP_REQUEST_METHODS}.method_put)
		do
			if req.is_chunked_input then
				do_put (req, res)
			else
				if req.content_length_value > 0 then
					do_put (req, res)
				else
					handle_bad_request_response ("Bad request, content_length empty", req, res)
				end
			end
		end

	do_put (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			handle_not_implemented ("Method PUT not implemented", req, res)
		end

feature -- Method DELETE

	execute_delete (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute `req' responding into `res'.
		require
			req_attached: req /= Void
			res_attached: res /= Void
			delete_method: req.is_request_method ({HTTP_REQUEST_METHODS}.method_delete)
		do
			do_delete (req, res)
		end

	do_delete (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Here we use DELETE to logically delete a person.
			-- 204 if is ok
			-- 404 Resource not found
			-- 500 if we have an internal server error	
		do
			handle_not_implemented ("Method DELETE not implemented", req, res)
		end

feature -- Method CONNECT

	execute_connect (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute `req' responding into `res'.
		require
			req_attached: req /= Void
			res_attached: res /= Void
			connect_method: req.is_request_method ({HTTP_REQUEST_METHODS}.method_connect)
		do
			do_connect (req, res)
		end

	do_connect (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			handle_not_implemented ("Method CONNECT not implemented", req, res)
		end

feature -- Method HEAD

	execute_head (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute `req' responding into `res'.
		require
			req_attached: req /= Void
			res_attached: res /= Void
			head_method: req.is_request_method ({HTTP_REQUEST_METHODS}.method_head)
		do
			do_head (req, res)
		end

	do_head (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Using HEAD to retrieve resource information.
			-- If the HEAD request is SUCCESS, we respond with
			-- 200 OK, and WITHOUT a representation of the resource.
			-- If the HEAD request is not SUCCESS, we respond with
			-- 404 Resource not found.
			-- If Conditional HEAD and the resource does not change we send a
			-- 304, Resource not modifed.
		do
			handle_not_implemented ("Method HEAD not implemented", req, res)
		end

feature -- Method OPTIONS

	execute_options (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute `req' responding into `res'.
		require
			req_attached: req /= Void
			res_attached: res /= Void
			options_method: req.is_request_method ({HTTP_REQUEST_METHODS}.method_options)
		do
			do_options (req, res)
		end

	do_options (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			-- TODO - implement a default method that lists the accepted methods for the resource.
			handle_not_implemented ("Method OPTIONS not implemented", req, res)
		end

feature -- Method TRACE

	execute_trace (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute `req' responding into `res'.
		require
			req_attached: req /= Void
			res_attached: res /= Void
			trace_method: req.is_request_method ({HTTP_REQUEST_METHODS}.method_trace)
		do
			do_trace (req, res)
		end

	do_trace (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			-- TODO - implement frozen, as there is only one permitted semantic.
			handle_not_implemented ("Method TRACE not implemented", req, res)
		end

feature -- Method Extension Method

	execute_extension_method (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute `req' responding into `res'.
		require
			req_attached: req /= Void
			res_attached: res /= Void
		do
			do_extension_method (req, res)
		end

	do_extension_method (req: WSF_REQUEST; res: WSF_RESPONSE)
		-- Execute `req' responding into `res'.
	require
		req_attached: req /= Void
		res_attached: res /= Void
		do
			handle_not_implemented ("Method extension-method not implemented", req, res)
		end

feature -- Retrieve content from WGI_INPUT_STREAM

	retrieve_data  (req: WSF_REQUEST): STRING
			-- Retrieve the content from the input stream.
			-- Handle different transfers.
		require
			req_attached: req /= Void
		do
			create Result.make_empty
			req.read_input_data_into (Result)
		end

feature -- Handle responses
	-- TODO Handle Content negotiation.
	-- The option : Server-driven negotiation: uses request headers to select a variant
	-- More info : http://www.w3.org/Protocols/rfc2616/rfc2616-sec12.html#sec12

	-- TODO: review HTTP requirements on `a_description' for each individual error code.

	handle_error (a_description: STRING; a_status_code: INTEGER; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Handle an error.
		require
			a_description_attached: a_description /= Void
			a_status_code_valid: a_status_code > 0
			req_attached: req /= Void
			res_attached: res /= Void
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
			-- Handle error {HTTP_STATUS_CODE}.not_implemented.
		require
			a_description_attached: a_description /= Void
			req_attached: req /= Void
			res_attached: res /= Void
		do
			handle_error (a_description, {HTTP_STATUS_CODE}.not_implemented, req, res)
		end

	handle_bad_request_response (a_description: STRING; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Handle error {HTTP_STATUS_CODE}.bad_request.
		require
			a_description_attached: a_description /= Void
			req_attached: req /= Void
			res_attached: res /= Void
		do
			handle_error (a_description, {HTTP_STATUS_CODE}.bad_request, req, res)
		end

	handle_resource_not_found_response (a_description: STRING; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Handle error {HTTP_STATUS_CODE}.not_found.
		require
			a_description_attached: a_description /= Void
			req_attached: req /= Void
			res_attached: res /= Void
		do
			handle_error (a_description, {HTTP_STATUS_CODE}.not_found, req, res)
		end

	handle_forbidden (a_description: STRING; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Handle error {HTTP_STATUS_CODE}.forbidden.
		require
			a_description_attached: a_description /= Void
			req_attached: req /= Void
			res_attached: res /= Void
		do
			handle_error (a_description, {HTTP_STATUS_CODE}.forbidden, req, res)
		end

feature -- Handle responses: others		

	handle_precondition_fail_response (a_description: STRING; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Handle error {HTTP_STATUS_CODE}.precondition_failed.
		require
			a_description_attached: a_description /= Void
			req_attached: req /= Void
			res_attached: res /= Void
		do
			handle_error (a_description, {HTTP_STATUS_CODE}.precondition_failed, req, res)
		end

	handle_internal_server_error (a_description: STRING; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Handle error {HTTP_STATUS_CODE}.internal_server_error.
		require
			a_description_attached: a_description /= Void
			req_attached: req /= Void
			res_attached: res /= Void
		do
			handle_error (a_description, {HTTP_STATUS_CODE}.internal_server_error, req, res)
		end

	handle_method_not_allowed_response (a_description: STRING; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Handle error {HTTP_STATUS_CODE}.method_not_allowed.
		require
			a_description_attached: a_description /= Void
			req_attached: req /= Void
			res_attached: res /= Void
		do
			handle_error (a_description, {HTTP_STATUS_CODE}.method_not_allowed, req, res)
		end

	handle_resource_not_modified_response (a_description: STRING; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Handle error {HTTP_STATUS_CODE}.not_modified.
		require
			a_description_attached: a_description /= Void
			req_attached: req /= Void
			res_attached: res /= Void
		do
			handle_error (a_description, {HTTP_STATUS_CODE}.not_modified, req, res)
		end

	handle_resource_conflict_response (a_description: STRING; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Handle error {HTTP_STATUS_CODE}.conflict.
		require
			a_description_attached: a_description /= Void
			req_attached: req /= Void
			res_attached: res /= Void
		do
			handle_error (a_description, {HTTP_STATUS_CODE}.conflict, req, res)
		end

note
	copyright: "2011-2013, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
