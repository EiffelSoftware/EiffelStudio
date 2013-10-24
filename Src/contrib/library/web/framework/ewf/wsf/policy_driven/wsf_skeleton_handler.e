note

	description: "[
						Policy-driven handlers.
						Implementers only need to concentrate on creating content.
						]"
	date: "$Date$"
	revision: "$Revision$"

deferred class WSF_SKELETON_HANDLER

inherit

	WSF_URI_TEMPLATE_HANDLER
		redefine
			execute
		end

	WSF_OPTIONS_POLICY

	WSF_PREVIOUS_POLICY

	WSF_CACHING_POLICY

	WSF_METHOD_HELPER_FACTORY

	WSF_SELF_DOCUMENTED_HANDLER

feature {NONE} -- Initialization

	make_with_router (a_router: WSF_ROUTER)
			-- Initialize `router'.
		require
			a_router_attached: a_router /= Void
		do
			router := a_router
		ensure
			router_aliased: router = a_router
		end

feature -- Router

	router: WSF_ROUTER
			-- So that WSF_OPTIONS_POLICY can find the allowed methods

feature -- Execution variables

	Negotiated_language_execution_variable: STRING = "NEGOTIATED_LANGUAGE"
			-- Execution variable set by framework

	Negotiated_charset_execution_variable: STRING = "NEGOTIATED_CHARSET"
			-- Execution variable set by framework

	Negotiated_media_type_execution_variable: STRING = "NEGOTIATED_MEDIA_TYPE"
			-- Execution variable set by framework

	Negotiated_encoding_execution_variable: STRING = "NEGOTIATED_ENCODING"
			-- Execution variable set by framework

	Negotiated_http_header_execution_variable: STRING = "NEGOTIATED_HTTP_HEADER"
			-- Execution variable set by framework

	Request_entity_execution_variable: STRING = "REQUEST_ENTITY"
			-- Execution variable set by framework

	Conflict_check_code_execution_variable: STRING = "CONFLICT_CHECK_CODE"
		-- Execution variable set by framework

	Content_check_code_execution_variable: STRING = "CONTENT_CHECK_CODE"
		-- Execution variable set by framework

	Request_check_code_execution_variable: STRING = "REQUEST_CHECK_CODE"
		-- Execution variable set by framework

feature -- Access

	is_chunking (req: WSF_REQUEST): BOOLEAN
		-- Will the response to `req' using chunked transfer encoding?
		require
			req_attached: req /= Void
		deferred
		end

	includes_response_entity (req: WSF_REQUEST): BOOLEAN
			-- Does the response to `req' include an entity?
			-- Method will be DELETE, OUT, POST or an extension method.
		require
			req_attached: req /= Void
		deferred
		end

	conneg (req: WSF_REQUEST): SERVER_CONTENT_NEGOTIATION
			-- Content negotiation for `req';
			-- This would normally be a once object, ignoring `req'.
		require
			req_attached: req /= Void
		deferred
		end

	mime_types_supported (req: WSF_REQUEST): LIST [STRING]
			-- All values for Accept header that `Current' can serve
		require
			req_attached: req /= Void
		deferred
		ensure
			mime_types_supported_includes_default: Result.has (conneg (req).default_media_type)
		end

	languages_supported (req: WSF_REQUEST): LIST [STRING]
			-- All values for Accept-Language header that `Current' can serve
		require
			req_attached: req /= Void
		deferred
		ensure
			languages_supported_includes_default: Result.has (conneg (req).default_language)
		end

	charsets_supported (req: WSF_REQUEST): LIST [STRING]
			-- All values for Accept-Charset header that `Current' can serve
		require
			req_attached: req /= Void
		deferred
		ensure
			charsets_supported_includes_default: Result.has (conneg (req).default_charset)
		end

	encodings_supported (req: WSF_REQUEST): LIST [STRING]
			-- All values for Accept-Encoding header that `Current' can serve
		require
			req_attached: req /= Void
		deferred
		ensure
			encodings_supported_includes_default: Result.has (conneg (req).default_encoding)
		end

	additional_variant_headers (req: WSF_REQUEST): detachable LIST [STRING]
			-- Header other than Accept, Accept-Language, Accept-Charset and Accept-Encoding,
			--  which might affect the response
		do
		end

	predictable_response (req: WSF_REQUEST): BOOLEAN
			-- Does the response to `req' vary only on the dimensions of ContentType, Language, Charset and Transfer encoding,
			--  plus those named in `additional_variant_headers'?
		do
			Result := True
			-- redefine to return `False', so as to induce a Vary: * header
		end

	matching_etag (req: WSF_REQUEST; a_etag: READABLE_STRING_32; a_strong: BOOLEAN): BOOLEAN
			-- Is `a_etag' a match for resource requested in `req'?
			-- If `a_strong' then the strong comparison function must be used.
		require
			req_attached: req /= Void
		deferred
		end

	etag (req: WSF_REQUEST): detachable READABLE_STRING_8
			-- Optional Etag for response entity to `req';
			-- Upto four execution variables may be set on `req':
			-- "NEGOTIATED_MEDIA_TYPE"
			-- "NEGOTIATED_LANGUAGE"
			-- "NEGOTIATED_CHARSET"
			-- "NEGOTIATED_ENCODING"
		require
			req_attached: req /= Void
		deferred
		end

	modified_since (req: WSF_REQUEST; a_date_time: DATE_TIME): BOOLEAN
			-- Has resource requested in `req' been modified since `a_date_time' (UTC)?
		require
			req_attached: req /= Void
		deferred
		end

	treat_as_moved_permanently (req: WSF_REQUEST): BOOLEAN
			-- Rather than store as a new entity, do we treat it as an existing entity that has been moved?
		require
			req_attached: req /= Void
			put_request: req.is_request_method ({HTTP_REQUEST_METHODS}.method_put)
		do
			-- No. Redefine this if needed.
		end

	allow_post_to_missing_resource (req: WSF_REQUEST): BOOLEAN
			-- The resource named in `req' does not exist, and this is a POST. Do we allow it?
		require
			req_attached: req /= Void
		deferred
		end

feature -- Measurement

	content_length (req: WSF_REQUEST): NATURAL
			-- Length of entity-body of the response to `req'
		require
			req_attached: req /= Void
			not_chunked: not is_chunking (req)
		deferred
		end

feature -- Status report

	finished (req: WSF_REQUEST): BOOLEAN
			-- Has the last chunk been generated for `req'?
		require
			req_attached: req /= Void
			chunked: is_chunking (req)
		deferred
		end


feature -- Documentation

	mapping_documentation (m: WSF_ROUTER_MAPPING; a_request_methods: detachable WSF_REQUEST_METHODS): WSF_ROUTER_MAPPING_DOCUMENTATION
			-- Documentation associated with Current handler, in the context of the mapping `m' and methods `a_request_methods'
			--| `m' and `a_request_methods' are useful to produce specific documentation when the handler is used for multiple mapping.
		do
			create Result.make (m)
			Result.add_description (description)
		end

	description: READABLE_STRING_GENERAL
			-- General description for self-generated documentation;
			-- The specific URI templates supported will be described automatically
		deferred
		ensure
			description_attached: Result /= Void
		end

feature -- DELETE

	delete (req: WSF_REQUEST)
			-- Delete resource named in `req' or set an error on `req.error_handler'.
		require
			req_attached: req /= Void
		deferred
		ensure
			error_or_queued_or_deleted: not req.error_handler.has_error implies (delete_queued (req) or deleted (req))
		end

	deleted (req: WSF_REQUEST): BOOLEAN
			-- Has resource named by `req' been deleted?
		require
			req_attached: req /= Void
		do
			if not req.error_handler.has_error then
				Result := True
			end
		ensure
			negative_implication: not Result implies req.error_handler.has_error
		end

	delete_queued (req: WSF_REQUEST): BOOLEAN
			-- Has resource named by `req' been queued for deletion?
		require
			req_attached: req /= Void
		deferred
		ensure
			entity_available: includes_response_entity (req)
		end

feature -- GET/HEAD content

	ensure_content_available (req: WSF_REQUEST)
			-- Commence generation of response text (entity-body) (if not already done in `check_resource_exists').
			-- If not chunked, then this will create the entire entity-body so as to be available
			--  for a subsequent call to `content'.
			-- If chunked, only the first chunk will be made available to `next_chunk'. If chunk extensions
			--  are used, then this will also generate the chunk extension for the first chunk.
			-- Upto four execution variables may be set on `req':
			-- "NEGOTIATED_MEDIA_TYPE"
			-- "NEGOTIATED_LANGUAGE"
			-- "NEGOTIATED_CHARSET"
			-- "NEGOTIATED_ENCODING"
			-- If you support etags, and you have more than one possible representation
			--  for the resource (so that your etag depends upon the particular representation),
			--  then you will probably have already created the response entity in `check_resource_exists'.
		require
			req_attached: req /= Void
			get_or_head_or_delete: req.is_get_head_request_method or req.is_delete_request_method
		deferred
		end

	response_ok (req: WSF_REQUEST): BOOLEAN
			-- Has generation of the response (so-far, if chunked) proceeded witout error?
		require
			req_attached: req /= Void
		do
			Result := not req.error_handler.has_error
		ensure
			last_error_set: Result = not req.error_handler.has_error
		end

	content (req: WSF_REQUEST): READABLE_STRING_8
			-- Non-chunked entity body in response to `req';
			-- Upto four execution variables may be set on `req':
			-- "NEGOTIATED_MEDIA_TYPE"
			-- "NEGOTIATED_LANGUAGE"
			-- "NEGOTIATED_CHARSET"
			-- "NEGOTIATED_ENCODING"
		require
			req_attached: req /= Void
			head_get_or_delete: req.is_get_head_request_method or req.is_delete_request_method
			no_error: response_ok (req)
			not_chunked: not is_chunking (req)
		deferred
		end

	generate_next_chunk (req: WSF_REQUEST)
			-- Prepare next chunk (including optional chunk extension) of entity body in response to `req'.
			-- This is not called for the first chunk.
			-- Upto four execution variables may be set on `req':
			-- "NEGOTIATED_MEDIA_TYPE"
			-- "NEGOTIATED_LANGUAGE"
			-- "NEGOTIATED_CHARSET"
			-- "NEGOTIATED_ENCODING"
		require
			req_attached: req /= Void
			no_error: response_ok (req)
			chunked: is_chunking (req)
		deferred
		end

	next_chunk (req: WSF_REQUEST): TUPLE [a_check: READABLE_STRING_8; a_extension: detachable READABLE_STRING_8]
			-- Next chunk of entity body in response to `req';
			-- The second field of the result is an optional chunk extension.
				-- Four execution variables are set on `req':
			-- "NEGOTIATED_MEDIA_TYPE"
			-- "NEGOTIATED_LANGUAGE"
			-- "NEGOTIATED_CHARSET"
			-- "NEGOTIATED_ENCODING"
		require
			req_attached: req /= Void
			no_error: response_ok (req)
			chunked: is_chunking (req)
		deferred
		end

feature -- PUT/POST

	read_entity (req: WSF_REQUEST)
			-- Read request body and set as `req.execution_variable (Request_entity_execution_variable)'.
		require
			req_attached: req /= Void
		local
			l_body: STRING
		do
			create l_body.make_empty
			req.read_input_data_into (l_body)
			if not l_body.is_empty then
				req.set_execution_variable (Request_entity_execution_variable, l_body)
			end
		end

	is_entity_too_large (req: WSF_REQUEST): BOOLEAN
			-- Is the entity stored in `req.execution_variable (Request_entity_execution_variable)' too large for the application?
		require
			req_attached: req /= Void
		deferred
		end

	check_content_headers (req: WSF_REQUEST)
			-- Check we can support all content headers on request entity.
			-- Set `req.execution_variable (Content_check_code_execution_variable)' to {NATURAL} zero if OK, or 415 or 501 if not.
		require
			req_attached: req /= Void
		deferred
		end

	content_check_code (req: WSF_REQUEST): NATURAL
			-- Code set by `check_content_headers'.
		require
			req_attached: req /= Void
		do
			if attached {NATURAL} req.execution_variable (Content_check_code_execution_variable) as l_code then
				Result := l_code
			end
		end

	create_resource (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Create new resource in response to a PUT request when `check_resource_exists' returns `False'.
			-- Implementor must set error code of 200 OK or 500 Server Error.
		require
			req_attached: req /= Void
			res_attached: res /= Void
			put_request: req.is_put_request_method
		deferred
		end

	append_resource (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Create new resource in response to a POST request.
			-- Implementor must set error code of 200 OK or 204 No Content or 303 See Other or 500 Server Error.
		require
			req_attached: req /= Void
			res_attached: res /= Void
			post_request: req.is_post_request_method
		deferred
		end

	check_conflict (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Check to see if updating the resource is problematic due to the current state of the resource.
			-- Set `req.execution_variable (Conflict_check_code_execution_variable)' to {NATURAL} zero if OK, or 409 if not.
			-- In the latter case, write the full error response to `res'.
		require
			req_attached: req /= Void
			res_attached: res /= Void
		deferred
		end

	conflict_check_code (req: WSF_REQUEST): NATURAL
			-- Code set by `check_conflict'.
		require
			req_attached: req /= Void
		do
			if attached {NATURAL} req.execution_variable (Conflict_check_code_execution_variable) as l_code then
				Result := l_code
			end
		end

	check_request (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Check that the request entity is a valid request.
			-- The entity is available as `req.execution_variable (Conflict_check_code_execution_variable)'.
			-- Set `req.execution_variable (Request_check_code_execution_variable)' to {NATURAL} zero if OK, or 400 if not.
			-- In the latter case, write the full error response to `res'.
		require
			req_attached: req /= Void
			res_attached: res /= Void
			put_or_post: req.is_put_post_request_method
		deferred
		end

	request_check_code (req: WSF_REQUEST): NATURAL
			-- Code set by `check_request'.
		require
			req_attached: req /= Void
		do
			if attached {NATURAL} req.execution_variable (Request_check_code_execution_variable) as l_code then
				Result := l_code
			end
		end

	update_resource (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Perform the update requested in `req'.
			-- Write a response to `res' with a code of 204 or 500.
		require
			req_attached: req /= Void
			res_attached: res /= Void
			put_request: req.is_put_request_method
		deferred
		end

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		do
			check
				known_method: router.allowed_methods_for_request (req).has (req.request_method)
				not_trace: not req.is_request_method ({HTTP_REQUEST_METHODS}.method_trace)
				not_connect: not req.is_request_method ({HTTP_REQUEST_METHODS}.method_connect)
			end
			if req.is_request_method ({HTTP_REQUEST_METHODS}.method_options) then
				execute_options (req, res, router)
			else
				if attached new_method_helper (req.request_method) as l_helper then
					execute_method (req, res, l_helper)
				else
					handle_internal_server_error (res)
				end
			end
		end

	execute_method (req: WSF_REQUEST; res: WSF_RESPONSE; a_helper: WSF_METHOD_HELPER)
			-- Write response to `req' into `res', using `a_helper' as a logic helper.
		require
			req_attached: req /= Void
			res_attached: res /= Void
			a_helper_attached: a_helper /= Void
		do
			a_helper.handle_content_negotiation (req, res, Current)
			if not res.status_is_set or else res.status_code /= {HTTP_STATUS_CODE}.Not_acceptable then
				check_resource_exists (req, a_helper)
				if a_helper.resource_exists then
					a_helper.execute_existing_resource (req, res, Current)
				elseif req.error_handler.has_error then
					a_helper.write_error_response (req, res)
				else
					if attached req.http_if_match as l_if_match and then l_if_match.same_string ("*") then
						a_helper.handle_precondition_failed (req, res)
					else
						a_helper.execute_new_resource (req, res, Current)
					end
				end
			end
		end

	check_resource_exists (req: WSF_REQUEST; a_helper: WSF_METHOD_HELPER)
			-- Call `a_helper.set_resource_exists' to indicate that `req.path_translated'
			--  is the name of an existing resource.
			-- Upto four execution variables may be set on `req':
			-- "NEGOTIATED_MEDIA_TYPE"
			-- "NEGOTIATED_LANGUAGE"
			-- "NEGOTIATED_CHARSET"
			-- "NEGOTIATED_ENCODING"
			-- If you support etags, and you have more than one possible representation
			--  for the resource (so that your etag depends upon the particular representation),
			--  then you will probably need to create the response entity at this point, rather
			--  than in `ensure_content_available'.
		require
			req_attached: req /= Void
			a_helper_attached: a_helper /= Void
		deferred
		end

feature {NONE} -- Implementation

	handle_internal_server_error (res: WSF_RESPONSE)
			-- Write "Internal Server Error" response to `res'.
		require
			res_attached: res /= Void
		local
			h: HTTP_HEADER
			m: STRING_8
		do
			create h.make
			h.put_content_type_text_plain
			m := "Server failed to handle request properly"
			h.put_content_length (m.count)
			h.put_current_date
			res.set_status_code ({HTTP_STATUS_CODE}.internal_server_error)
			res.put_header_lines (h)
			res.put_string (m)
		ensure
			response_status_is_set: res.status_is_set
			status_is_service_unavailable: res.status_code = {HTTP_STATUS_CODE}.internal_server_error
			body_sent: res.message_committed and then res.transfered_content_length > 0
		end

note
	copyright: "2011-2013, Colin Adams, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
